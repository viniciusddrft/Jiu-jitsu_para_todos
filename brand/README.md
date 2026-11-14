# Identidade visual — “Tatame”

Guia da identidade do **Jiu-jitsu para todos**. O tema transforma o app num tatame
à noite: fundo escuro, uma única cor de destaque e as faixas do jiu-jitsu como
linguagem visual.

- Protótipo com todas as telas: <https://claude.ai/artifact/VZv6wSnyFPZPmsW15mqJfW>
- Implementação no app: [`lib/src/shared/themes/`](../lib/src/shared/themes) e
  [`lib/src/shared/components/`](../lib/src/shared/components)
- Tokens em JSON: [`tokens.json`](tokens.json)

## Princípios

1. **Uma cor só.** O vermelho da ponteira da faixa preta aparece apenas na ação
   principal da tela e no estado ativo. Todo o resto é neutro.
2. **Faixas como linguagem, nunca decoração.** A cor da faixa sempre significa
   um nível (ex.: dificuldade do quiz). Não use faixa onde ela sugeriria uma
   graduação que não existe — por isso o marcador de luta não tem faixas.
3. **Toda faixa tem ponteira.** Branca, azul, roxa e marrom: ponteira **preta**.
   Preta: ponteira **vermelha**.
4. **Ícones de traço.** Linha de ~1,75 px, cantos arredondados. Sem ilustrações
   coloridas.
5. **Usabilidade sem cliques extras.** Ações frequentes em um toque (ex.: placar:
   tocar soma, segurar desfaz).

## Cores

| Token | Nome | Hex | Uso |
|---|---|---|---|
| `background` | Tatame | `#0D1017` | Fundo do app |
| `surface` | Lona | `#161B24` | Cartões, fundo do ícone |
| `surfaceHigh` | Lona alta | `#1F2632` | Elementos dentro de cartões |
| `line` | Linha | `#2A3240` | Bordas, divisores |
| `text` | Kimono | `#F4F1EA` | Texto principal, botões claros |
| `textSoft` | — | `#C9CED8` | Texto corrido |
| `textMuted` | Névoa | `#A3ABB9` | Rótulos, texto secundário |
| `accent` | Ponteira | `#E5484D` | **Única** cor de destaque |
| `success` | — | `#3DD68C` | Resposta certa (só feedback) |

### Faixas

| Faixa | Cor | Ponteira |
|---|---|---|
| Branca | `#F4F1EA` | `#050608` |
| Azul | `#3E7BFA` | `#050608` |
| Roxa | `#8E5CF7` | `#050608` |
| Marrom | `#9A6440` | `#050608` |
| Preta | `#050608` | `#E5484D` |

No quiz, a faixa indica **a dificuldade das perguntas** (“Nível Faixa
Branca/Azul/Preta”), nunca a faixa de quem joga.

## Tipografia

| Estilo | Fonte | Peso | Uso |
|---|---|---|---|
| Display | Barlow Condensed | 800, caixa alta | Títulos de tela, números grandes, placar |
| Título | Barlow Condensed | 700, caixa alta | Títulos de cartão, perguntas |
| Rótulo pequeno | Inter | 600, 12 px, espaçado, caixa alta | Sobretítulos (“QUIZ”, “HISTÓRIA”) |
| Corpo | Inter | 400, 15 px | Textos |
| Rótulo | Inter | 600 | Botões e opções |

Fontes do Google Fonts (licença OFL), carregadas via `google_fonts`.

## Logo

| Arquivo | Uso |
|---|---|
| [`logo/symbol.svg`](logo/symbol.svg) | Símbolo: faixa preta com ponteira vermelha e dois graus |
| [`logo/lockup.svg`](logo/lockup.svg) | Assinatura: símbolo + “JIU-JITSU **PARA TODOS**” |

Regras: não distorcer a proporção da faixa (≈ 200 × 52), não trocar as cores, não
usar a ponteira de outra cor. Sobre fundo escuro, a faixa leva o contorno
`#2A3240` para não sumir.

## Ícone do app (opção B “Tatame”)

| Arquivo | Uso |
|---|---|
| [`icon/icon.svg`](icon/icon.svg) | Referência vetorial |
| [`icon/icon.png`](icon/icon.png) | Ícone completo (Android < 8) |
| [`icon/icon_foreground.png`](icon/icon_foreground.png) | Ícone adaptativo — primeiro plano (fundo `#161B24`) |
| [`icon/icon_monochrome.png`](icon/icon_monochrome.png) | Ícone temático do Android 13+ |

## Splash

Padrão do Android 12+: ícone central sobre fundo Tatame (`#0D1017`), dentro de
um círculo Lona (`#161B24`).

| Arquivo | Uso |
|---|---|
| [`splash/splash_android12.png`](splash/splash_android12.png) | Android 12+ |
| [`splash/splash_legacy.png`](splash/splash_legacy.png) | Android < 12 |

## Componentes

| Componente | Arquivo | Observação |
|---|---|---|
| `Belt`, `BrandBelt` | `components/belt.dart` | Faixa com ponteira; ponteira proporcional à altura |
| `AppCard`, `NavCard`, `AppButton`, `BeltChip` | `components/app_card.dart` | Cartões, botão principal (56 px) |
| `AppTopBar`, `PageHeading` | `components/app_top_bar.dart` | Voltar/fechar + título grande |
| `NativeAdSlot` | `components/native_ad_slot.dart` | Anúncio nativo integrado (layout em `res/layout/list_tile_native_ad.xml`) |
| `OfflineState` | `components/offline_state.dart` | Erro de rede |

Raios: botão 16, cartão 22–24, painel inferior 28. Área de toque mínima 44 px.

## Regenerar ícone e splash

Os PNGs do app (`assets/images/application_icon/`, `assets/splash/`) são
gerados por script, sem dependências:

```bash
python3 tool/generate_brand_assets.py
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

Depois, copie os PNGs atualizados para esta pasta.
