"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const string_builder_1 = require("./string-builder");
const vs = require("vscode");
class SnippetStringBuilder {
    constructor() {
        this._snippet = new vs.SnippetString();
    }
    append(value) {
        this._snippet.appendText(value.toString());
        return this;
    }
    appendLine(value = '') {
        this.append(value.toString() + '\n');
        return this;
    }
    appendSnippetTabstop(index) {
        this._snippet.appendTabstop(index);
        return this;
    }
    appendSnippetPlaceholder(value, index) {
        this._snippet.appendPlaceholder(value, index);
        return this;
    }
    appendSnippetVariable(name, defaultValue) {
        this._snippet.appendVariable(name, defaultValue);
        return this;
    }
    toCommentValue(updateWithMap = false) {
        let sb = new string_builder_1.StringBuilder();
        // if (!updateWithMap) {
        //   sb.appendLine();
        // }
        sb.appendLine('/**');
        const lines = this._snippet.value.split('\n');
        lines.forEach((line, i) => {
            if (line === '' && i === lines.length - 1) {
                return;
            }
            sb.append(' * ');
            sb.appendLine(line);
        });
        sb.appendLine(' */');
        return new vs.SnippetString(sb.toString());
    }
}
exports.SnippetStringBuilder = SnippetStringBuilder;
//# sourceMappingURL=snippet-string-builder.js.map