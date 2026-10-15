# University presets

A preset is a small `.tex` file that reproduces the style rules of a specific
university, school or Master's programme on top of the generic template:
names, colours, headers and footers, margins, spacing, etc.

## Using a preset

1. Add the class options that the preset asks for in `main.tex` (fonts,
   `uppercase`...). Class options cannot be set from a preset.
2. Add `\input{presets/<preset-name>}` at the **top** of `config.tex`, before
   your own data, so that anything you set afterwards takes precedence.

## Available presets

| File | University / school | Notes |
|------|---------------------|-------|
| `uja-epsj.tex` | Universidad de Jaén – Escuela Politécnica Superior de Jaén | Style of the original TFG template by F. Charte. Option: `uppercase`. |

## Contributing a preset

Presets for other universities are very welcome. Please:

- name the file `<university>-<school>.tex` in lower case (e.g. `urv-etse.tex`);
- start it with a header that cites the **official regulation or style guide**
  it is based on (title, year and URL), and the class options it needs;
- only set what the regulation requires; do not edit `tfmthesis.cls`;
- do not include logos or other trademarks: each user downloads their own;
- check that the template still compiles (`latexmk main.tex`) and add a row to
  the table above.
