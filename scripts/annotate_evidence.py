#!/usr/bin/env python3
"""Create an annotated screenshot copy; never modify the source.

Usage:
python -m pip install Pillow
python scripts/annotate_evidence.py input.png output.png --box 120,80,620,300 --label "UI-003: total visible" --status PASS
"""
from pathlib import Path
import argparse
from PIL import Image, ImageDraw, ImageFont

COLORS = {"PASS": (28,145,75), "FAIL": (190,45,45), "WARN": (190,125,15), "INFO": (35,105,180)}

def font_for(size):
    for path in ("/System/Library/Fonts/Supplemental/Arial.ttf",
                 "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
                 "C:/Windows/Fonts/arial.ttf"):
        if Path(path).exists():
            return ImageFont.truetype(path, size)
    return ImageFont.load_default()

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("input", type=Path); p.add_argument("output", type=Path)
    p.add_argument("--box", help="x1,y1,x2,y2"); p.add_argument("--label", default="")
    p.add_argument("--status", choices=COLORS, default="INFO")
    a = p.parse_args()
    if not a.input.is_file(): p.error(f"Input does not exist: {a.input}")
    if a.input.resolve() == a.output.resolve(): p.error("Output must differ from input.")
    im = Image.open(a.input).convert("RGB"); d = ImageDraw.Draw(im)
    color = COLORS[a.status]; f = font_for(max(16, im.width // 55))
    if a.box:
        try: x1,y1,x2,y2 = (int(v.strip()) for v in a.box.split(","))
        except Exception as e: p.error(f"Expected x1,y1,x2,y2: {e}")
        if not (0 <= x1 < x2 <= im.width and 0 <= y1 < y2 <= im.height):
            p.error("Box coordinates must be inside image with positive area.")
        d.rectangle((x1,y1,x2,y2), outline=color, width=max(3, im.width//400))
    if a.label:
        pad=8; b=d.textbbox((0,0),a.label,font=f); w=b[2]-b[0]; h=b[3]-b[1]
        d.rounded_rectangle((12,12,w+28,h+28),radius=6,fill=color)
        d.text((20,20),a.label,fill="white",font=f)
    a.output.parent.mkdir(parents=True,exist_ok=True); im.save(a.output)
    print(f"Annotated copy saved: {a.output}")

if __name__ == "__main__": main()
