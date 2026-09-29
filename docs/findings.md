# Findings

## Inputs
- Requirements source: `requirements/000同济大学研究生学位论文写作参考示例（2025版）.doc`
- Visual reference: `requirements/000同济大学研究生学位论文写作参考示例（2025版）.pdf`
- Chinese font files: `fonts/simsun.ttf`, `fonts/simhei.ttf`, `fonts/simfang.ttf`, `fonts/lishu.ttf`

## Formatting Requirements
- Paper: A4 portrait.
- Chinese cover logo: 10.0 cm x 2.6 cm, centered.
- Chinese cover degree: Lishu, size 2 (22 pt), bold, centered, single spacing, 0.5 line before.
- Degree type: Lishu, size 3 (16 pt), bold, centered, single spacing.
- Chinese title: SimHei, size 2 (22 pt), bold, centered, single spacing.
- Chinese cover metadata: FangSong, size 3 (16 pt), single spacing, 4.5-character left indent.
- Chinese cover date: SimSun, size 3 (16 pt), centered, single spacing.
- English cover description: Times New Roman, size 4 (14 pt), centered, single spacing, no paragraph spacing (first line has 0.5 line before according to annotation).
- English title: Arial, small size 2 (18 pt), bold, centered, single spacing.
- English metadata and date: Times New Roman, size 3 (16 pt), single spacing; metadata indented 4.5 characters; date centered.
- Chinese abstract heading: SimHei, size 3 (16 pt), bold, centered, single spacing, 24 pt before and 18 pt after.
- Chinese abstract body: SimSun, small size 4 (12 pt), 20 pt fixed leading, no paragraph spacing, first-line indent 2 Chinese characters; “关键词” bold.
- English abstract heading: Arial, size 3 (16 pt), bold, centered, same spacing as Chinese heading.
- English abstract body: Times New Roman, small size 4 (12 pt), 20 pt fixed leading, no paragraph spacing; “Key Words” bold.
- Front-matter footer page number: SimSun size 5 (10.5 pt); Abstract uses Times New Roman size 5.
- Table of contents heading: same 16 pt SimHei centered heading spacing; entries SimSun small size 4 (12 pt), 18 pt leading, no paragraph spacing, page numbers right-aligned.
- Chapter heading: SimHei, size 3 (16 pt), bold, centered, single spacing, 24 pt before, 18 pt after; one Chinese-character space between chapter number and title.
- Level-1 section heading: SimHei, small size 3 (15 pt), single spacing, 24 pt before, 6 pt after; one character between number and title.
- Level-2 section heading: SimHei, size 4 (14 pt), single spacing, 12 pt before, 6 pt after; one character between number and title.
- Main body: SimSun small size 4 (12 pt), English Times New Roman 12 pt, justified, 2-character first-line indent, fixed 20 pt leading, no paragraph spacing. Formula-containing paragraphs may adjust leading.
- First body line on continuation pages: approximately 0.7 line before.
- Equations centered with number right-aligned.
- Figure caption: below figure, SimSun size 5 (10.5 pt), centered, single spacing, 6 pt before and 12 pt after; one character between figure number and title.
- References heading uses chapter-heading style. Entries: SimSun size 5 (10.5 pt), English Times New Roman, 2-character hanging indent, fixed 16 pt leading, no paragraph spacing.
- Appendix body uses normal body style.
- Acknowledgements heading uses chapter-heading style; body FangSong small size 4 (12 pt), justified, 20 pt leading, no paragraph spacing, first-line indent 2 characters.
- CV/publications heading uses chapter-heading style; body SimSun size 5 (10.5 pt), English Times New Roman, fixed 16 pt leading, no paragraph spacing; subsection labels bold; publications follow reference format.
- Visual measurement of the reference PDF gives an approximately 2.5 cm left margin and 3.0 cm right margin; these values are used by the template.
- The supplied PDF contains the official combined Tongji logo as a 1950 x 500 embedded image. It was extracted losslessly to `assets/tongji-logo-000.png` and is rendered at exactly 10.0 cm x 2.6 cm.
- The final PDF embeds and subsets the repository font files. `pdffonts` confirms SimSun, SimHei, FangSong, and `./fonts/lishu.ttf` in the output.

## Verification
- `latexmk -xelatex -interaction=nonstopmode -halt-on-error main.tex` succeeds.
- Final output: A4, 12 pages, no LaTeX warning, overfull, underfull, or error messages.
- Front matter uses uppercase Roman numerals I, II, III; main matter restarts at Arabic 1.
- Representative cover, abstract, contents, body, figure/table, and bibliography pages were rendered and visually compared with the reference PDF.

## Strict Visual Audit (second pass)
- The reference running-header rule/body block is approximately x=147..845 px at 120 dpi, indicating near-symmetric 3.1 cm side margins. The current template uses x=118..850 px because its left/right margins are 2.5/3.0 cm.
- Current running headers are about 20 pt too high; footers are about 14-18 pt too low.
- `ctexbook` line spread multiplies the requested `\fontsize{12bp}{20bp}` and `10.5bp/16bp`, producing approximately 26 pt and 20.8 pt actual baselines. Fixed leading requires `\linespread{1}` before `\selectfont`.
- Chapter/abstract/back-matter titles are generally about 14 pt too low; current title-to-body gaps are also too large.
- Chinese cover: logo is roughly 1.3 cm too high, top title group about 0.7 cm too high, title-to-metadata gap about 1.9 cm too small, and metadata block is too far left.
- English cover: the three introductory lines are much tighter than the reference, title and metadata are too high, and the metadata should be a left-aligned inline list rather than a stretched two-column table.
- The TOC first page needs the same running header as the sample; entries use fixed 18 pt leading.
- Current section headings are visually over-bold because SimHei is additionally synthesized bold.
- Acknowledgements and CV inherit expanded leading and use an overly wide text block.
- Declaration headings/body are too small, the page incorrectly has a running header rule, paragraphs lack the reference two-character indent, signatures use unwanted underline rules, and both declaration sections are compressed into one page instead of the reference two-page layout.

## Final Visual Alignment
- Main text and running-rule block now spans approximately x=147..845 px at 120 dpi, matching the reference.
- Running header baseline/rule and footer baseline now align with the reference within a few pixels.
- Chinese cover logo, degree labels, title, metadata block, and date now align with the corresponding reference blocks.
- English cover logo, description, title, metadata start and line pitch now align; metadata values remain inline so real thesis information can be populated without the previous stretched-column distortion.
- Chinese/English abstracts now have matching title position, first-line indent, 20 pt baseline pitch, keyword spacing, and Roman page numbers.
- TOC uses matching title position, 18 pt row pitch, and corrected second-/third-level indents.
- Chapter and section starts now reproduce the larger vertical gap visible in the Word/PDF sample while preserving fixed 20 pt body leading.
- Spine strip width, height, title, author and university positions were measured against reference page 3 and adjusted.
- Declarations now reproduce the reference's two-page structure and use a dedicated no-header page style.
- Final output has 14 pages rather than 16 because the template contains less demonstration body text; structural pagination through the spine, front matter, and two declaration pages matches the reference.

## Authoritative Word Page Setup
- User confirmed the Word margins are 2.54 cm top/bottom and 3.17 cm left/right; these replace the earlier PDF-derived estimates.
- The header measurement is defined from the physical top edge to the visible top of the header text, which lies at 2.00 cm. The rule sits below the text and is not the page-edge measurement reference.
- The footer is positioned so the visible footer text ends approximately 1.50 cm above the physical bottom edge, accounting for the difference between Word's footer-edge convention and LaTeX's baseline-based `\footskip`.
- Final vector verification uses `headsep=-9.85pt` and `footskip=0.96cm`: the header glyph top is 56.696 pt from the top (target 56.693 pt), while the footer glyph bottom is 42.519 pt from the bottom (target 42.520 pt).
- Chapter headings explicitly use single line spacing and 18 bp after-spacing. Their effective page-start offset is calibrated from the running-header rule: rule y=69.383 pt and heading glyph top y=93.381 pt, a 23.998 pt gap.
- The running-header rule is 0.75 bp. Vector inspection of the generated PDF reports `stroke-width="0.75"`.
- Heading digits and letters (第1章, 1.1, 附录 A) use SimHei via a dedicated `\heilatin` font family in the heading formats; body digits remain Times New Roman. Verified by glyph widths: heading `1.1` measures 1.5 em (SimHei half-width digits) instead of the previous 1.25 em (Times).
- The abstract `关键词：` label uses bold SimSun. The `song` family and CJK main font map bold to faux-bold SimSun (`AutoFakeBold=2.5`) instead of SimHei, matching Word's bolded SimSun; this also turns the declaration signature labels and CV section labels into bold SimSun, consistent with the reference sample. Verified strokes: 0.3011 pt at 12 bp (关键词), 0.2635 pt at 10.5 bp (CV labels).
- xeCJK's `CJKecglue` defaults to `~` (the current Latin font's space width). After heading digits switched to `\heilatin` (SimHei, space width 0.5 em), the `第1章` gaps grew to 8 pt per side, roughly double the reference's 4.31/4.35 pt. The chapter format now overrides `\CJKsetecglue{\hskip 0.27em plus 0.08em minus 0.08em}` locally, producing 4.31 pt gaps and a 48.62 pt total width versus the reference's 48.86 pt. The running header keeps the Times space (2.625 pt) and matches the reference within 0.06 pt.
- `titlesec` was silently neutralizing all ctex section/subsection `beforeskip`/`afterskip` values (probe: 69 bp and 180 bp both had no effect), leaving headings with line-pitch-only spacing. The unused package was removed, restoring ctex heading spacing.
- Heading vertical spacing is calibrated against reference ink gaps: chapter title top y=103.6, title-to-first-section 39.97 pt (`chapter/afterskip=37.1bp`), body-to-section 34.28 pt (`section/beforeskip=30.9bp`), section-to-body 19.72 pt (`section/afterskip=12.1bp`), section-to-subsection 28.63 pt (`subsection/beforeskip=26bp` with a `\@nobreak` reset so the preskip is not discarded), subsection-to-body 25.17 pt (`subsection/afterskip=17.5bp`). Final build matches every target within 0.05 pt, and 参考文献/附录/致谢 titles all land at y=103.61 like the reference chapters.
- In a `.cls` file `@` is already a letter; adding `\makeatother` breaks every later `\tongji@...` name (manifested as "Missing \begin{document}"). Never `\makeatother` inside the class.
- Number-to-title gaps use `\enspace` (0.5 em, scaling with heading size) matching the reference's 8.39/7.44/7.10 pt at chapter/section/subsection; final gaps 8.00/7.50/7.00 pt. The full alignment methodology is documented in `ALIGNMENT.md`.
- TOC leader dots match the reference's 6.0 pt pitch (`\renewcommand{\cftdotsep}{2.25}`; tocloft's default 4.5 mu produced 9.0 pt).
- Chinese cover form rebuilt from measured reference coordinates: labels left-aligned at x=178 pt, two-character labels spread over a 4-character field, full-width colons boxed so values start cleanly at x=258 pt, row pitch exactly 31.2 pt, first row top at 441.95 pt, last row at 691.55 pt, date top at 753.90 pt. The old tabular version mis-spread labels (`\hfill` overrode centering), misaligned 4-character labels, and let xeCJK punctuation compression overlap values into the colon.
- English cover uses its own English metadata (`\thesisauthoren`, `\schoolen`, `\categoryen`, `\disciplineen`, `\subdisciplineen`, `\researchfielden`, `\supervisoren`, `\associatesupervisoren`, `\jointinstitutionen`) rendered as a `\leftskip=83.66pt` hanging-indent list at x=173.2 pt with 31 pt pitch; long entries wrap aligned under their labels like the Word sample.

## Pitfall: `\label` right after a sectioning command
- `\section{X}\label{y}` (label on its own line, or followed by a blank line) adds an extra
  blank line of about 12.1 pt when the next content is another heading (`\subsection{...}`).
  `\ctexset`'s `\@xsect` ends with `\ignorespaces` while a paragraph is still pending, so the
  label's write whatsit lands in that otherwise empty horizontal list; the `\par` issued by the
  following heading then typesets it as a line.
- Measured ink-gap from the section title to the subsection title (600 dpi): 43.66 pt without
  the label (reference sample: 43.75 pt, so 43.66 pt is correct), 55.76 pt with the label on its
  own line, 55.76 pt with a blank line in between. Body text between the headings makes it
  harmless.
- Verified workaround: put the label inside the section argument, `\section{X\label{y}}`
  (43.66 pt). Equivalent: place the label after the section's first body paragraph.
- Template-level attempts that were tried and reverted (each gave a wrong value): appending
  `\par` to `\@xsect`; recording the afterskip in `\@afterheading` and cancelling it from the
  `\subsection` wrapper; adding `\vskip\z@` before the wrapper's `\addvspace`. Results were
  29.76 pt or 55.76 pt instead of 43.66 pt, so the class keeps the stock ctex behaviour.
