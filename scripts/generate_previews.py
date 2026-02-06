#!/usr/bin/env python3
"""Generate per-theme preview PNGs without external dependencies."""

from __future__ import annotations

import json
import struct
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
THEMES_DIR = ROOT / "themes"
PREVIEWS_DIR = ROOT / "assets" / "previews"
WIDTH = 1200
HEIGHT = 630


def hex_to_rgb(value: str) -> tuple[int, int, int]:
    value = value.lstrip("#")
    return tuple(int(value[i : i + 2], 16) for i in (0, 2, 4))


def clamp(v: float) -> int:
    return max(0, min(255, int(round(v))))


def blend(a: tuple[int, int, int], b: tuple[int, int, int], t: float) -> tuple[int, int, int]:
    return (
        clamp(a[0] + (b[0] - a[0]) * t),
        clamp(a[1] + (b[1] - a[1]) * t),
        clamp(a[2] + (b[2] - a[2]) * t),
    )


class Canvas:
    def __init__(self, w: int, h: int, bg: tuple[int, int, int]) -> None:
        self.w = w
        self.h = h
        self.pixels = bytearray(bg * (w * h))

    def fill_rect(self, x: int, y: int, w: int, h: int, color: tuple[int, int, int]) -> None:
        x0 = max(0, x)
        y0 = max(0, y)
        x1 = min(self.w, x + w)
        y1 = min(self.h, y + h)
        if x0 >= x1 or y0 >= y1:
            return
        for yy in range(y0, y1):
            row = yy * self.w * 3
            for xx in range(x0, x1):
                i = row + xx * 3
                self.pixels[i : i + 3] = bytes(color)

    def fill_h_gradient(
        self,
        x: int,
        y: int,
        w: int,
        h: int,
        left: tuple[int, int, int],
        right: tuple[int, int, int],
    ) -> None:
        for xx in range(w):
            t = 0 if w <= 1 else xx / (w - 1)
            c = blend(left, right, t)
            self.fill_rect(x + xx, y, 1, h, c)

    def stroke_rect(self, x: int, y: int, w: int, h: int, color: tuple[int, int, int], thickness: int = 1) -> None:
        self.fill_rect(x, y, w, thickness, color)
        self.fill_rect(x, y + h - thickness, w, thickness, color)
        self.fill_rect(x, y, thickness, h, color)
        self.fill_rect(x + w - thickness, y, thickness, h, color)

    def to_png(self) -> bytes:
        raw = bytearray()
        stride = self.w * 3
        for y in range(self.h):
            raw.append(0)  # no filter
            start = y * stride
            raw.extend(self.pixels[start : start + stride])

        def chunk(tag: bytes, data: bytes) -> bytes:
            return (
                struct.pack(">I", len(data))
                + tag
                + data
                + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)
            )

        ihdr = struct.pack(">IIBBBBB", self.w, self.h, 8, 2, 0, 0, 0)
        idat = zlib.compress(bytes(raw), 9)
        return b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr) + chunk(b"IDAT", idat) + chunk(b"IEND", b"")


def render_preview(theme_path: Path) -> Path:
    data = json.loads(theme_path.read_text())
    name = data["name"]
    v = data["vars"]

    bg = hex_to_rgb(v["bg"])
    panel = hex_to_rgb(v["panel"])
    panel_alt = hex_to_rgb(v["panelAlt"])
    border = hex_to_rgb(v["border"])
    selected = hex_to_rgb(v["selected"])

    accent = hex_to_rgb(v["accent"])
    cyan = hex_to_rgb(v["cyan"])
    green = hex_to_rgb(v["green"])
    red = hex_to_rgb(v["red"])
    yellow = hex_to_rgb(v["yellow"])
    purple = hex_to_rgb(v["purple"])
    orange = hex_to_rgb(v["orange"])
    text = hex_to_rgb(v["text"])
    muted = hex_to_rgb(v["muted"])

    c = Canvas(WIDTH, HEIGHT, bg)

    # shell frame
    c.fill_rect(26, 26, WIDTH - 52, HEIGHT - 52, panel)
    c.stroke_rect(26, 26, WIDTH - 52, HEIGHT - 52, border, 2)

    # top bar
    top_h = 68
    c.fill_h_gradient(26, 26, WIDTH - 52, top_h, panel_alt, selected)
    c.stroke_rect(26, 26 + top_h, WIDTH - 52, 2, border, 2)

    # three traffic lights / status chips
    c.fill_rect(50, 49, 22, 22, red)
    c.fill_rect(84, 49, 22, 22, yellow)
    c.fill_rect(118, 49, 22, 22, green)

    # sidebar
    side_x, side_y, side_w, side_h = 42, 108, 290, 478
    c.fill_rect(side_x, side_y, side_w, side_h, panel_alt)
    c.stroke_rect(side_x, side_y, side_w, side_h, border, 2)

    y = 130
    for i, color in enumerate((accent, cyan, green, purple, orange, muted, text)):
        c.fill_rect(64, y, 12, 12, color)
        c.fill_rect(86, y, 210 - i * 8, 12, blend(color, panel_alt, 0.5))
        y += 27

    # main content area
    main_x, main_y, main_w, main_h = 352, 108, 806, 478
    c.fill_rect(main_x, main_y, main_w, main_h, panel)
    c.stroke_rect(main_x, main_y, main_w, main_h, border, 2)

    # message blocks
    c.fill_rect(main_x + 24, main_y + 24, 520, 66, selected)
    c.fill_rect(main_x + 24, main_y + 106, 700, 76, panel_alt)
    c.fill_rect(main_x + 24, main_y + 198, 650, 56, panel_alt)

    # syntax-like bars
    sx = main_x + 36
    sy = main_y + 288
    bars = [
        (accent, 180),
        (purple, 125),
        (cyan, 200),
        (green, 160),
        (red, 95),
        (orange, 145),
        (muted, 220),
    ]
    for i, (color, length) in enumerate(bars):
        c.fill_rect(sx, sy + i * 24, length, 12, color)

    # bottom palette row
    swatches = [accent, cyan, green, red, yellow, purple, orange, text]
    sw_w = 90
    gap = 10
    row_w = len(swatches) * sw_w + (len(swatches) - 1) * gap
    start_x = main_x + main_w - row_w - 24
    y_sw = main_y + main_h - 52
    for i, sw in enumerate(swatches):
        x = start_x + i * (sw_w + gap)
        c.fill_rect(x, y_sw, sw_w, 26, sw)
        c.stroke_rect(x, y_sw, sw_w, 26, border, 1)

    # deterministic theme marker stripe so previews are always distinct by theme name
    name_seed = sum(ord(ch) for ch in name)
    stripe_h = 8 + (name_seed % 8)
    stripe_color = blend(accent, purple, (name_seed % 100) / 100)
    c.fill_rect(26, HEIGHT - 26 - stripe_h, WIDTH - 52, stripe_h, stripe_color)

    PREVIEWS_DIR.mkdir(parents=True, exist_ok=True)
    out = PREVIEWS_DIR / f"{name}.png"
    out.write_bytes(c.to_png())
    return out


def main() -> None:
    generated = []
    for theme_path in sorted(THEMES_DIR.glob("*.json")):
        if theme_path.name == ".gitkeep":
            continue
        generated.append(render_preview(theme_path))
    for path in generated:
        print(path.relative_to(ROOT))


if __name__ == "__main__":
    main()
