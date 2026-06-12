// ====================================================================
// LabGuardian 通用排版工具
//   - 兼容 main.typ / gnn_paper.typ 原有色板（IntelBlue / GNNGreen ...）
//   - 新增 "学术冷色" 调色板 (academic-*) 与三线表 (tlt) 工具
//   - 新增 fletcher / codly 辅助宏；不强制依赖（图按需 import）
// ====================================================================

// ─── 原有色板（保留向后兼容）──────────────────────────────────────
#let IntelBlue  = rgb("#0071C5")
#let GNNGreen   = rgb("#2E8B57")
#let WarnOrange = rgb("#D97706")
#let SoftGray   = rgb("#F3F4F6")
#let DarkGray   = rgb("#374151")

// ─── 学术 IEEE 风格色板（v2：接近黑白，几乎不用花色背景）────────
//   关键洞察（来自 IEEE Trans. 类期刊插图实践）:
//     1. 绝大多数 card 用白底或浅灰底 (luma 245-250)；
//     2. 边框统一深灰 (acad-ink)，**禁止彩色描边稀释层次**；
//     3. 颜色只在 *徽章 label* 上以 *实心深色 + 白字* 形式高对比出现；
//     4. 强调时只用单一品牌色 (IEEE 蓝 #005A9B) 极少量点缀。
//
//   命名仍保留 acad-L1..L5 三件套以兼容老代码：
//     acad-L*    : 徽章实心填色（深色）
//     acad-L*-bg : 卡片背景色（极浅灰为主，仅强调层加 1% 蓝/红）
#let acad-ink         = rgb("#1F2937")  // 主线 / 边框
#let acad-rule        = rgb("#374151")  // 表格三线
#let acad-muted       = rgb("#6B7280")  // 注释 / 灰字
#let acad-accent      = rgb("#005A9B")  // IEEE 深蓝（唯一品牌色）
#let acad-accent-bg   = rgb("#F1F5F9")  // 与卡片底统一的极浅灰

// 卡片背景（极浅）— 几乎全部统一到一种近白灰，差异留给徽章
#let acad-bg-plain    = rgb("#FAFAFA")  // 通用 card 背景（最常用）
#let acad-bg-emphasis = rgb("#EFF3F7")  // 强调 card 背景（带一点点蓝）
#let acad-bg-warn     = rgb("#FBF7EE")  // 警告 card 背景（带一点点暖）

// 五层 card 背景：全部用 plain，仅徽章颜色不同
#let acad-L1-bg = acad-bg-plain
#let acad-L2-bg = acad-bg-emphasis  // Decision Layer = 核心，略带蓝调
#let acad-L3-bg = acad-bg-plain
#let acad-L4-bg = acad-bg-plain
#let acad-L5-bg = acad-bg-plain

// 五层徽章颜色：取自 ColorBrewer "PuBuGn" + IEEE 蓝衍生
//   底层 → 顶层 = 深 → 中 → 浅蓝，符合 "L1 是基底" 的视觉直觉
#let acad-L1          = rgb("#1F2937")  // 深石板灰（基底）
#let acad-L2          = rgb("#005A9B")  // IEEE 深蓝（决策层，强调）
#let acad-L3          = rgb("#0F766E")  // 墨青（检索层）
#let acad-L4          = rgb("#3F3F46")  // 中灰（编排层）
#let acad-L5          = rgb("#525B6B")  // 钢灰（表达层）

// ─── card：旧版（main.typ 仍在用）+ acad-card 学术版 ──────────────
#let card(body, fill: rgb("#F8FAFC"), stroke: IntelBlue, width: auto) = block(
  width: width,
  inset: 8pt,
  radius: 4pt,
  fill: fill,
  stroke: 0.8pt + stroke,
)[#body]

// 学术版 card：低饱和底色 + 1pt 同色边框 + 1pt 圆角；可选 label 加在右上
#let acad-card(body, fill: acad-accent-bg, stroke: acad-accent, label: none,
              width: auto, inset: 7pt) = block(
  width: width,
  inset: inset,
  radius: 2pt,
  fill: fill,
  stroke: 1pt + stroke,
)[
  #if label != none [
    #place(top + right, dx: 4pt, dy: -4pt)[
      #box(fill: stroke, inset: (x: 4pt, y: 1pt), radius: 1pt,
        text(size: 7.5pt, fill: white, weight: "bold")[#label])
    ]
  ]
  #body
]

#let arrow         = text(size: 18pt, fill: DarkGray)[→]
#let acad-arrow    = text(size: 14pt, fill: acad-ink, weight: "bold")[→]
#let tiny-note(x)  = text(size: 8.5pt, fill: DarkGray)[#x]
#let acad-note(x)  = text(size: 8pt, fill: acad-muted)[#x]


// ─── 三线表 (Booktabs) ────────────────────────────────────────────
//   遵循学术规范：顶线 (1pt) + 表头底线 (0.5pt) + 底线 (1pt)，无竖线。
//
//   用法:
//     #tlt(
//       columns: (1fr, auto, auto),
//       align: (left, center, right),
//       header: ([Method], [Acc.], [Lat.]),
//       rows: (
//         ([CNN], [0.87], [10ms]),
//         ([GNN], [0.92], [12ms]),
//       ),
//     )
#let tlt(columns: (), align: auto, header: (), rows: ()) = {
  let header-row = header.map(c => table.cell(fill: none)[#strong[#c]])
  table(
    columns: columns,
    align: align,
    stroke: (x, y) => if y == 0 {
      (top: 1pt + acad-rule, bottom: 0.5pt + acad-rule)
    } else if y == rows.len() {
      (bottom: 1pt + acad-rule)
    } else { none },
    inset: (x: 6pt, y: 4pt),
    ..header-row,
    ..rows.flatten(),
  )
}

// 兼容性变体：调用方手写 table 时只想用三线 stroke
#let tlt-stroke = (x, y) => (
  if y == 0 { (top: 1pt + acad-rule, bottom: 0.5pt + acad-rule) }
  else { (bottom: 0pt) }
)


// ─── IEEE 页眉 ────────────────────────────────────────────────────
//   charged-ieee 自身不支持 header；在 ieee.with(...) 之后用
//   `set page(header: ...)` 覆盖即可。第 1 页（含 title）不显示。
#let acad-header(left-text: [], right-text: []) = context {
  if counter(page).get().first() == 1 {
    none
  } else {
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      text(size: 8pt, font: ("TeX Gyre Termes", "Times New Roman"), style: "italic")[#left-text],
      text(size: 8pt, font: ("TeX Gyre Termes", "Times New Roman"), style: "italic")[#right-text],
    )
    v(-6pt)
    line(length: 100%, stroke: 0.4pt + acad-rule)
  }
}
