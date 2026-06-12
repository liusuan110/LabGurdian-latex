#import "../../defs.typ": *


#figure(
  card(
    grid(
      columns: (1fr, auto, 1fr, auto, 1fr),
      gutter: 10pt,
      align: center,
      card([Component 节点\ U1 / R1\ 元件类型、子型号], fill: rgb("#EEF6FF")),
      [#text(size: 16pt)[--has_port--→]],
      card([Port 节点\ pin2 / pin3\ 引脚角色、极性、对称类], fill: rgb("#ECFDF5"), stroke: GNNGreen),
      [#text(size: 16pt)[--connects--→]],
      card([Net 节点\ VIN / VOUT / GND\ 网络角色、role label], fill: rgb("#FFF7ED"), stroke: WarnOrange),
    ),
    width: 100%,
  ),
  caption: [HeteroCircuitGraph 的三类节点与两类边],
) <fig:hcg>
