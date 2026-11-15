#!/usr/bin/env python3
"""Gera os PNGs do ícone e do splash da identidade "Tatame".

O símbolo é a faixa preta com ponteira vermelha e dois graus brancos.
Sem dependências (PNG escrito à mão), para rodar em qualquer máquina:

    python3 tool/generate_brand_assets.py
    dart run flutter_launcher_icons
    dart run flutter_native_splash:create
"""
import struct
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

KIMONO = (0xF4, 0xF1, 0xEA, 255)
LONA = (0x16, 0x1B, 0x24, 255)  # fundo do ícone (opção B "Tatame")
LINHA = (0x2A, 0x32, 0x40, 255)  # contorno da faixa sobre o fundo escuro
FAIXA_PRETA = (0x05, 0x06, 0x08, 255)
TATAME = (0x0D, 0x10, 0x17, 255)
PONTEIRA = (0xE5, 0x48, 0x4D, 255)
WHITE = (255, 255, 255, 255)
CLEAR = (0, 0, 0, 0)


def canvas(size, color=CLEAR):
    return [[color] * size for _ in range(size)]


def rect(img, x0, y0, x1, y1, color):
    for y in range(max(0, round(y0)), min(len(img), round(y1))):
        row = img[y]
        for x in range(max(0, round(x0)), min(len(row), round(x1))):
            row[x] = color


def circle(img, cx, cy, r, color, ss=4):
    """Círculo com anti-aliasing por supersampling nas bordas."""
    size = len(img)
    for y in range(max(0, int(cy - r - 1)), min(size, int(cy + r + 2))):
        for x in range(max(0, int(cx - r - 1)), min(size, int(cx + r + 2))):
            inside = 0
            for sy in range(ss):
                for sx in range(ss):
                    dx = x + (sx + 0.5) / ss - cx
                    dy = y + (sy + 0.5) / ss - cy
                    inside += dx * dx + dy * dy <= r * r
            if inside:
                a = color[3] * inside / (ss * ss)
                img[y][x] = blend(img[y][x], color[:3] + (a,))


def blend(dst, src):
    sa = src[3] / 255
    da = dst[3] / 255
    oa = sa + da * (1 - sa)
    if oa == 0:
        return CLEAR
    rgb = tuple(
        round((src[i] * sa + dst[i] * da * (1 - sa)) / oa) for i in range(3))
    return rgb + (round(oa * 255),)


def belt(img, cx, cy, width, body=FAIXA_PRETA, tip=PONTEIRA, stripes=WHITE,
         outline=LINHA):
    """Faixa centrada em (cx, cy). Proporções iguais ao widget BrandBelt.
    O contorno separa a faixa preta do fundo escuro."""
    height = width * 0.26
    x0, y0 = cx - width / 2, cy - height / 2
    if outline:
        o = max(2, width * 0.012)
        rect(img, x0 - o, y0 - o, x0 + width + o, y0 + height + o, outline)
    rect(img, x0, y0, x0 + width, y0 + height, body)
    tip_w = width * 0.33
    gap = width * 0.09
    tx0 = x0 + width - gap - tip_w
    rect(img, tx0, y0, tx0 + tip_w, y0 + height, tip)
    stripe_w = width * 0.035
    for i in (1, 2):
        sx = tx0 + tip_w * i / 3 - stripe_w / 2
        rect(img, sx, y0, sx + stripe_w, y0 + height, stripes)


def save(img, path):
    size = len(img)
    raw = b"".join(
        b"\x00" + b"".join(bytes(px) for px in row) for row in img)

    def chunk(kind, data):
        return (struct.pack(">I", len(data)) + kind + data +
                struct.pack(">I", zlib.crc32(kind + data) & 0xFFFFFFFF))

    png = (b"\x89PNG\r\n\x1a\n" +
           chunk(b"IHDR", struct.pack(">IIBBBBB", size, size, 8, 6, 0, 0, 0)) +
           chunk(b"IDAT", zlib.compress(raw, 9)) + chunk(b"IEND", b""))
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(png)
    print(f"gerado {path.relative_to(ROOT)}")


def main():
    icons = ROOT / "assets/images/application_icon"
    splash = ROOT / "assets/splash"

    # Ícone completo (Android < 8): fundo escuro + faixa.
    img = canvas(1024, LONA)
    belt(img, 512, 512, 640)
    save(img, icons / "icon.png")

    # Ícone adaptativo (Android 8+): só a faixa, dentro da zona segura.
    img = canvas(1024)
    belt(img, 512, 512, 500)
    save(img, icons / "icon_foreground.png")

    # Ícone temático (Android 13+): silhueta; o sistema pinta a cor.
    img = canvas(1024)
    belt(img, 512, 512, 500, body=WHITE, tip=WHITE, stripes=CLEAR, outline=None)
    save(img, icons / "icon_monochrome.png")

    # Splash Android 12+: o sistema desenha o círculo escuro atrás.
    img = canvas(960)
    belt(img, 480, 480, 440)
    save(img, splash / "splash_icon.png")

    # Splash Android < 12: círculo escuro + faixa sobre o fundo tatame.
    img = canvas(600)
    circle(img, 300, 300, 240, LONA)
    belt(img, 300, 300, 300)
    save(img, splash / "splash.png")


if __name__ == "__main__":
    main()
