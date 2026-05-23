#import "../../defs.typ": *

// Intent-Unified LangGraph（学术极简版）
#figure(
  acad-card(
    grid(
      columns: 1,
      gutter: 6pt,
      // 入口
      align(center, acad-card(
        fill: acad-bg-emphasis, stroke: acad-ink,
        [LLM 意图分类 (Ollama JSON / 关键词兜底)\
         #acad-note[决策 intent ∈ \{ diagnostic, concept_tutor, lab_guidance, mixed \}]]
      )),
      align(center, acad-arrow),
      // 节点链
      grid(
        columns: 9,
        column-gutter: 4pt,
        align: center + horizon,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[classify\_error]]),
        acad-arrow,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[build\_context\_pack]\
           #acad-note[intent → 白名单]]),
        acad-arrow,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[react_plan]]),
        acad-arrow,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[react_observe]]),
        acad-arrow,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[react_reflect]\
           #acad-note[intent → 模板]]),
      ),
      align(center, [#h(40%)#text(size: 14pt, fill: acad-muted)[↻ ×N]]),
      align(center, acad-arrow),
      grid(
        columns: 7,
        column-gutter: 4pt,
        align: center + horizon,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[verify_answer]\
           #acad-note[intent → 规则]]),
        acad-arrow,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[repair_answer]\
           #acad-note[fail 分支]]),
        h(0.5em),
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#text(size: 9pt)[vlm_explain]\
           #acad-note[micro defect]]),
        acad-arrow,
        acad-card(fill: acad-bg-emphasis, stroke: acad-ink,
          [#text(size: 9pt)[finalize_answer]\
           #acad-note[intent ∈ \{diag, mixed\}\
           → LLM polish]]),
      ),
      align(center, acad-note[
        统一图：4 种意图共享主干 · 差异仅由 #strong[3 个节点局部分支]：build\_context\_pack 白名单 / react\_reflect 模板 / verify\_answer 规则
      ]),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [Intent-Unified ReAct LangGraph。同一图服务 4 种意图，状态机的差异仅在三个节点局部分支，verifier、reflection、repair 等机制可一处升级、处处生效。],
) <fig:intent-graph>
