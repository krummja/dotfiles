"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class StringBuilder {
    constructor() {
        this._text = '';
    }
    append(text = '') {
        this._text += text.toString();
    }
    /**
     * TODO: comment appendLine
     * Appends line
     * @param [text]
     */
    appendLine(text = '') {
        this._text += text.toString() + '\n';
    }
    /**
     * // TODO: comment toString
     * To string
     * @returns string
     */
    toString() {
        return this._text;
    }
}
exports.StringBuilder = StringBuilder;
//# sourceMappingURL=string-builder.js.map