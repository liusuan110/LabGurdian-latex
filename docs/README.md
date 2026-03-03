把封面/任务书 PDF 放到这个目录，用于在 `Project_LabGuardian_Updated.tex` 中自动插入。

- `cover.pdf`：竞赛方案报告封面（建议用竞赛风格，而非本科论文封面）
- `task.pdf`：任务书/立项书/项目任务说明（可选）

文档里使用了 `\IfFileExists{docs/cover.pdf}{\includepdf[pages=-]{docs/cover.pdf}}{}` 的方式：
- 文件存在就插入
- 文件不存在就跳过（仍会生成内置的竞赛封面页）
