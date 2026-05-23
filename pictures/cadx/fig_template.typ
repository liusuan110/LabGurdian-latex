#import "../../defs.typ": *

// Template 五字段语义分解（学术极简版：统一灰底，仅徽章传层级）
#figure(
  acad-card(
    grid(
      columns: 1,
      gutter: 8pt,
      align: left,
      align(center, text(weight: "bold")[模板示例：NPN 差分放大器 (differential_pair_v1)]),
      grid(
        columns: (1fr, 1fr),
        gutter: 8pt,
        acad-card(label: "①required",
          fill: acad-bg-plain, stroke: acad-ink,
          [必须出现，否则模板不匹配。\
           · 2× NPN BJT (Q1, Q2)\
           · 2× collector resistor (Rc1, Rc2)\
           · tail current path (Re 或 current source)\
           · VCC / -VEE / GND 三条电源线
          ]),
        acad-card(label: "②optional",
          fill: acad-bg-plain, stroke: acad-ink,
          [缺失不扣分。\
           · 输入端偏置电阻 Rb1, Rb2\
           · 失调零点电位器\
           · 输入耦合电容
          ]),
        acad-card(label: "③forbidden",
          fill: acad-bg-plain, stroke: acad-ink,
          [出现即降分或拒绝。\
           · 反馈电容 (会变成积分器)\
           · 单端输入耦合 (破坏差分)
          ]),
        acad-card(label: "④variants",
          fill: acad-bg-plain, stroke: acad-ink,
          [合法实现变体（设计选择，不是错误）。\
           · `tail_resistor`：用 Re 简化\
           · `current_source`：用 BJT+基准 提升 CMRR
          ]),
      ),
      acad-card(label: "⑤parametric_invariants",
        fill: acad-bg-emphasis, stroke: acad-ink,
        [跨组件数值约束（不是结构约束，是关系约束）。匹配器在数值可用时执行；不可用时挂在 result 上由 advisor 提示。\
         · `diff_pair_symmetry`：$|R_(c 1) - R_(c 2)| slash R_(c 1) < 0.1$ (severity = warning)\
         · `tail_current_min`：$I_e gt.eq 1 thin "mA"$ (severity = error, requires_values = true)
        ]),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [TopologyTemplate 五字段语义分解 (Parametric Invariants Framework)。五层语义把"必须 / 不能 / 可选 / 合法变体 / 参数约束"显式分类，使模板既能容忍学生的合法设计选择，又能精确指出违反教学规范的接线。参数约束行以浅蓝衬底标识为本工作的关键创新。],
) <fig:template-5fields>
