# TypeScript Grammar Extended

This extension adds a handful of features to VS Code's default TypeScript grammar.

**Features:**
- Variable, import/export, and function identifiers in PascalCase will be tokenized as class names (workaround for VS Code's lack of support for semantic syntax highlighting, which will [hopefully be fixed soon](https://github.com/microsoft/vscode/issues/585))
- Object values in the format of ``template: `...` `` will be tokenized as embedded HTML (useful for 'inline' templates in Angular components and Angular Storybook stories)
