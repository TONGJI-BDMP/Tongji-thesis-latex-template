# 同济大学博士学位论文 LaTeX 模板

本模板依据 `requirements/000同济大学研究生学位论文写作参考示例（2025版）.doc` 中的文本框标注及对应 PDF 页面制作。

## 编译

模板必须使用 XeLaTeX：

```sh
latexmk -xelatex main.tex
```

清理中间文件：

```sh
latexmk -c
```

## 文件结构

- `tongjithesis.cls`：版式、字体、标题、页眉页脚、摘要、目录等定义。
- `main.tex`：文档组织入口。
- `contents/metadata.tex`：论文中英文元数据信息（同时写入 PDF 文档属性）。
- `contents/abstract.tex`：中英文摘要。
- `contents/`：各章节、附录、致谢和个人简历。
- `figures/`：论文插图；`figures/demo-figures.tex` 是示例插图的 TikZ 源文件，编译得到
  `figures/demo-figures.pdf`（共三页：单幅插图与子图示例的两个分图）。
- `assets/`：封面校标等模板资源。
- `fonts/`：模板显式加载的中文字体文件。
- `references.bib`：BibLaTeX 文献数据库。
- `docs/ALIGNMENT.md`：字体、字号、行距、标题间距等与参考样例的对齐说明；同目录还包含开发过程中的 `findings.md`、`progress.md` 和 `task_plan.md`。

## 字体

四种中文字体均在 `tongjithesis.cls` 中通过相对文件路径显式加载：

- 正文宋体：`fonts/simsun.ttf`
- 标题黑体：`fonts/simhei.ttf`
- 封面信息与致谢仿宋：`fonts/simfang.ttf`
- 封面学位信息隶书：`fonts/lishu.ttf`

西文字体使用系统的 Times New Roman 和 Arial。若在没有这两种字体的环境编译，请安装相应字体或在类文件中替换为可用的等宽度字体。

## 使用说明

1. 在 `contents/metadata.tex` 中修改题目、作者、学院、学科、导师和日期等中英文信息；英文封面使用对应的 `\thesisauthoren`、`\schoolen`、`\disciplineen`、`\supervisoren` 等英文信息命令；PDF 文档属性会同步写入标题、作者、主题和 `\thesiskeywords` 关键词。
2. 在 `contents/abstract.tex` 的 `cnabstract`、`enabstract` 环境中填写中英文摘要及关键词。
3. 按需要在 `contents/` 中增加章节，并在 `main.tex` 中使用 `\include` 引入。
4. 将图片放入 `figures/`，通过 `\includegraphics` 插入；含子图时用 `subcaption` 宏包的
   `subfigure` 环境（见 `contents/introduction.tex` 示例）。
5. 表格统一用 `tabularray` 宏包排版（三线表写法见 `contents/introduction.tex` 示例）。
6. 将文献写入 `references.bib`，正文用 `\cite{文献键}` 引用。
7. 模板默认输出单独的书脊打印页；设置 `\spinetitle` 修改书脊题目，不需要书脊时可注释 `\makespine`。

提交前应以研究生院当年发布的正式要求为准，并重点复核封面信息、声明页文字、纸质装订线和所在院系的补充规定。
