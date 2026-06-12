#import "../../defs.typ": *


#figure(
  card(
    grid(
      columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      rows: (auto, auto),
      gutter: 8pt,
      align: center,
      card([7 个 reference\ fixtures], fill: rgb("#EEF6FF")), arrow,
      card([12 类扰动\ operators], fill: rgb("#ECFDF5"), stroke: GNNGreen), arrow,
      card([label builder\ 边级标签], fill: rgb("#ECFDF5"), stroke: GNNGreen), arrow,
      card([ref-disjoint\ train / val / test], fill: rgb("#FFF7ED"), stroke: WarnOrange),
      tiny-note([opamp_buffer 整条留作 OOD test]), [], [], [], card([prebaked.pt\ SEAL tensors], fill: SoftGray, stroke: DarkGray), [], tiny-note([4200 samples\3240 / 360 / 600]),
    ),
    width: 100%,
  ),
  caption: [合成数据集生成、标签构建与 ref-disjoint 划分流程],
) <fig:dataset-flow>
