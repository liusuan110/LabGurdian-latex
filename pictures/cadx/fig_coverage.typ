#import "../../defs.typ": *

// 6 demo 拓扑 × 知识库覆盖矩阵（三线表 booktabs 规范）
#figure(
  tlt(
    columns: (auto, 1.6fr, 1.4fr, 1.6fr, 1.6fr),
    align: (center, left, center, center, center),
    header: ([\#], [Demo 拓扑], [Datasheet], [Teaching Scene], [Fault Cases]),
    rows: (
      ([1], [一阶 RC (微分/积分电路)],
        [`passive_capacitor_polarity`], [`exp_first_order_rc`], [5 个]),
      ([2], [共射放大器 (NPN 分压偏置)],
        [`bjt_8050`], [`exp_common_emitter_amplifier`], [3 个]),
      ([3], [差分放大器 (NPN 差分对)],
        [`bjt_8050` (共用)], [`exp_differential_amplifier`], [2 个]),
      ([4], [UA741 反相放大器],
        [`ua741`], [`exp_ua741_inverting_amplifier`], [3 个]),
      ([5], [UA741 加法器 (求和放大)],
        [`ua741` (共用)], [`exp_ua741_summing_amplifier`], [2 个]),
      ([6], [UA741 反相积分器],
        [`ua741` (共用)], [`exp_ua741_integrator`], [2 个]),
      ([], [#strong[合计]],
        [#strong[2 份 datasheet (12 chunks)]],
        [#strong[6 个 scene]],
        [#strong[17 个 fault case]]),
    ),
  ),
  kind: table,
  caption: [本地知识库对 6 个 demo 拓扑的覆盖矩阵。datasheet (12 chunks) + teaching_scene (含 expected_circuits / circuit_principles / common_faults) + 17 个 fault_case 共同支撑 RAG 检索，全部本地化无外网依赖。三线表遵循 booktabs 规范，去掉所有竖线与内部横线。],
) <tab:coverage>
