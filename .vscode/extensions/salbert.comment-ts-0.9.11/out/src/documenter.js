"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const ts = require("typescript");
const vs = require("vscode");
const languageServiceHost_1 = require("./languageServiceHost");
const utils = require("./utilities");
const snippet_string_builder_1 = require("./snippet-string-builder");
const string_builder_1 = require("./string-builder");
const determineVerbs = 'is;has;have;can;could;contains';
const noVerb = 'on;after;before;goto;do;must;should;shall;will;would;next;previous';
const postfixVerb = 'ing;ed';
class Documenter {
    /**
     * Creates an instance of documenter.
     */
    constructor() {
        this.currentComments = new Map();
        this._languageServiceHost = new languageServiceHost_1.LanguageServiceHost();
        this._services = ts.createLanguageService(this._languageServiceHost, ts.createDocumentRegistry());
    }
    _emitToDo(sb, name) {
        if (vs.workspace.getConfiguration().get('comment-ts.todoComments', false)) {
            sb.appendLine('TODO: comment ' + name);
        }
    }
    /**
     * TODO: comment _emitDescription
     * Emits description
     * @param sb
     * @param node
     * @param name
     * @returns
     */
    _emitDescription(sb, node, name) {
        const parseNames = vs.workspace.getConfiguration().get('comment-ts.parseNames', true);
        if (!parseNames) {
            return;
        }
        switch (node.kind) {
            case ts.SyntaxKind.GetAccessor: {
                const splitName = utils.separateCamelcase(name);
                const splitNameGet = utils.separateCamelcaseString(name);
                sb.append('Gets ');
                if (splitName && splitName.length > 1 && determineVerbs.indexOf(splitName[0].toLowerCase()) >= 0) {
                    sb.append('whether ');
                }
                sb.append(splitNameGet);
                sb.appendSnippetTabstop();
                break;
            }
            case ts.SyntaxKind.SetAccessor: {
                const splitName = utils.separateCamelcase(name);
                const splitNameSet = utils.separateCamelcaseString(name);
                sb.append('Sets ');
                if (splitName && splitName.length > 1 && determineVerbs.indexOf(splitName[0].toLowerCase()) >= 0) {
                    sb.append('whether ');
                }
                sb.append(splitNameSet);
                sb.appendSnippetTabstop();
                break;
            }
            case ts.SyntaxKind.PropertyDeclaration: {
                const splitName = utils.separateCamelcase(name);
                if (splitName && splitName.length > 1 && determineVerbs.indexOf(splitName[0].toLowerCase()) >= 0) {
                    sb.append('Determines whether ');
                    sb.append(utils.joinFrom(splitName, 1) + ' ');
                    sb.append(splitName[0]);
                }
                else if (splitName) {
                    sb.append(utils.capitalizeFirstLetter(splitName[0]) + ' ');
                    if (splitName.length > 1) {
                        sb.append(utils.joinFrom(splitName, 1));
                    }
                    const className = node.parent.name.getText();
                    sb.append(` of ${utils.separateCamelcaseString(className)}`);
                }
                sb.appendSnippetTabstop();
                break;
            }
            case ts.SyntaxKind.MethodDeclaration:
            case ts.SyntaxKind.FunctionExpression:
            case ts.SyntaxKind.ArrowFunction:
            case ts.SyntaxKind.FunctionDeclaration: {
                const splitName = utils.separateCamelcase(name);
                if (splitName && splitName.length > 1 && determineVerbs.indexOf(splitName[0].toLowerCase()) >= 0) {
                    sb.append('Determines whether ');
                    sb.append(utils.joinFrom(splitName, 1) + ' ');
                    sb.append(splitName[0]);
                }
                else if (splitName) {
                    if (splitName.length > 0) {
                        if (noVerb.indexOf(splitName[0].toLowerCase()) >= 0) {
                            // no verb
                            const verb = utils.capitalizeFirstLetter(splitName[0]);
                            sb.append(verb + ' ');
                        }
                        else if (splitName[0].length <= 2) {
                            // ignore prefix like ng
                            // splitName.splice(0, 1);
                        }
                        else if (splitName.length > 0) {
                            // verb
                            let verb = utils.capitalizeFirstLetter(splitName[0]);
                            sb.append(verb);
                            if (!this.endsWithOneOf(verb, postfixVerb) && !verb.endsWith('s')) {
                                // check if verb with s
                                if (verb.endsWith('y')) {
                                    // convert y > ie
                                    verb = verb.substr(0, verb.length - 1) + 'ie';
                                }
                                sb.append('s');
                            }
                            sb.append(' ');
                        }
                        if (splitName.length > 1) {
                            // more than one word, append rest
                            sb.append(utils.joinFrom(splitName, 1));
                        }
                        else if (splitName.length === 1) {
                            // if only one word append classname
                            const className = node.parent.name.getText();
                            sb.append(utils.separateCamelcaseString(className));
                        }
                        else {
                            // no word, take whole name
                            sb.append(utils.capitalizeFirstLetter(name));
                        }
                    }
                }
                sb.appendSnippetTabstop();
                break;
            }
            case ts.SyntaxKind.ClassDeclaration:
            case ts.SyntaxKind.InterfaceDeclaration:
            case ts.SyntaxKind.EnumDeclaration: {
                const splitClassName = utils.separateCamelcaseString(name);
                sb.append(utils.capitalizeFirstLetter(splitClassName));
                sb.appendSnippetTabstop();
                break;
            }
        }
    }
    /**
     * Ends with one of
     * @param verb
     * @param postfix
     * @returns true if with one of
     */
    endsWithOneOf(verb, postfix) {
        const postfixes = postfix.split(';');
        return postfixes.findIndex((p, index, arr) => verb.endsWith(p)) >= 0;
    }
    /**
     * Documents this function
     * more doku
     * and even more 7777
     * @param editor hurra 4444
     * @param commandName 111 6666
     * @param forCompletion 222 77777
     * @returns ret this 55555 uuuu
     */
    commentThis(editor, commandName, forCompletion) {
        const sourceFile = this._getSourceFile(editor.document);
        const selection = editor.selection;
        const caret = selection.start;
        this.currentComments = utils.createMap(editor, selection);
        const position = ts.getPositionOfLineAndCharacter(sourceFile, caret.line, caret.character);
        const node = utils.findChildForPosition(sourceFile, position);
        const documentNode = utils.nodeIsOfKind(node) ? node : utils.findFirstParent(node);
        if (!documentNode) {
            this._showFailureMessage(commandName, 'at the current position');
            return;
        }
        const sb = new snippet_string_builder_1.SnippetStringBuilder();
        const docLocation = this._documentNode(sb, documentNode, sourceFile);
        if (docLocation) {
            this._insertDocumentation(sb, docLocation, editor, forCompletion);
        }
        else {
            this._showFailureMessage(commandName, 'at the current position');
        }
    }
    /**
     * TODO: comment param
     * Params documenter
     * @param editor
     */
    traceNode(editor) {
        const selection = editor.selection;
        const caret = selection.start;
        const sourceFile = this._getSourceFile(editor.document);
        const position = ts.getPositionOfLineAndCharacter(sourceFile, caret.line, caret.character);
        const node = utils.findChildForPosition(sourceFile, position);
        const nodes = [];
        let parent = node;
        while (parent) {
            nodes.push(this._printNodeInfo(parent, sourceFile));
            parent = parent.parent;
        }
        const sb = new string_builder_1.StringBuilder();
        nodes.reverse().forEach((n, i) => {
            sb.appendLine(n);
        });
        if (!this._outputChannel) {
            this._outputChannel = vs.window.createOutputChannel('TypeScript Syntax Node Trace');
        }
        this._outputChannel.show();
        this._outputChannel.appendLine(sb.toString());
    }
    /**
     * Prints node info
     * @param node
     * @param sourceFile
     * @returns
     */
    _printNodeInfo(node, sourceFile) {
        const sb = new string_builder_1.StringBuilder();
        sb.append(`${node.getStart()} to ${node.getEnd()} --- (${node.kind}) ${ts.SyntaxKind[node.kind]}`);
        if (node.parent) {
            const nodeIndex = node.parent.getChildren().indexOf(node);
            if (nodeIndex !== -1) {
                sb.append(` - Index of parent: ${nodeIndex}`);
            }
        }
        sb.appendLine();
        const column = sourceFile.getLineAndCharacterOfPosition(node.getStart()).character;
        for (let i = 0; i < column; i++) {
            sb.append(' ');
        }
        sb.appendLine(node.getText());
        return sb.toString();
    }
    _showFailureMessage(commandName, condition) {
        vs.window.showErrorMessage(`Sorry! '${commandName}' wasn't able to produce documentation ${condition}.`);
    }
    /**
     * // TODO: comment _insertDocumentation
     * Inserts documentation
     * @param sb
     * @param location
     * @param editor
     * @param forCompletion
     */
    _insertDocumentation(sb, location, editor, forCompletion) {
        const startPosition = new vs.Position(forCompletion ? location.line - 1 : location.line, location.character);
        const endPosition = new vs.Position(location.line, location.character);
        // TODO: delete selection
        let range = new vs.Range(startPosition, endPosition);
        if (vs.workspace.getConfiguration().get('comment-ts.replaceComments', true)) {
            const startpos = editor.selection.start.line;
            const endpos = editor.selection.end.line;
            const startline = editor.document.lineAt(startpos).text.trim();
            const endline = editor.document.lineAt(endpos).text.trim();
            if (startline.startsWith('/**') && endline.startsWith('*/')) {
                range = new vs.Range(editor.selection.start, new vs.Position(editor.selection.end.line + 1, 0));
                vs.window.showInformationMessage('Comment updated from line ' + editor.selection.start.line + ' to ' + editor.selection.end.line);
            }
        }
        editor.insertSnippet(sb.toCommentValue(this.updateWithCurrentComments()), range);
    }
    /**
     * Updates with current comments
     * @returns true if with current comments
     */
    updateWithCurrentComments() {
        return this.currentComments.size > 0;
    }
    /**
     * comment _getSourceFileGets source file
     * @param document
     * @returns source file
     */
    _getSourceFile(document) {
        const fileText = document.getText();
        const canonicalFileName = utils.getDocumentFileName(document);
        this._languageServiceHost.updateCurrentFile(canonicalFileName, fileText);
        this._services.getSyntacticDiagnostics(canonicalFileName);
        const sourceFile = this._services.getProgram().getSourceFile(canonicalFileName);
        const newText = document.getText();
        sourceFile.update(newText, {
            newLength: newText.length,
            span: {
                start: 0,
                length: newText.length
            }
        });
        return sourceFile;
    }
    /**
     * TODO: comment _documentNode
     * Documents node
     * @param sb
     * @param node
     * @param sourceFile
     * @returns node
     */
    _documentNode(sb, node, sourceFile) {
        switch (node.kind) {
            case ts.SyntaxKind.ClassDeclaration:
                this._emitClassDeclaration(sb, node);
                break;
            case ts.SyntaxKind.PropertyDeclaration:
            case ts.SyntaxKind.PropertySignature:
            case ts.SyntaxKind.GetAccessor:
            case ts.SyntaxKind.SetAccessor:
                this._emitPropertyDeclaration(sb, node);
                break;
            case ts.SyntaxKind.InterfaceDeclaration:
                this._emitInterfaceDeclaration(sb, node);
                break;
            case ts.SyntaxKind.EnumDeclaration:
                this._emitEnumDeclaration(sb, node);
                break;
            case ts.SyntaxKind.EnumMember:
                sb.appendLine();
                break;
            case ts.SyntaxKind.FunctionDeclaration:
            case ts.SyntaxKind.MethodDeclaration:
            case ts.SyntaxKind.MethodSignature:
                this._emitMethodDeclaration(sb, node);
                break;
            case ts.SyntaxKind.Constructor:
                this._emitConstructorDeclaration(sb, node);
                break;
            case ts.SyntaxKind.FunctionExpression:
            case ts.SyntaxKind.ArrowFunction:
                return this._emitFunctionExpression(sb, node, sourceFile);
            case ts.SyntaxKind.VariableDeclaration:
                return this._emitVariableDeclaration(sb, node, sourceFile);
            default:
                return;
        }
        return ts.getLineAndCharacterOfPosition(sourceFile, node.getStart());
    }
    _emitMap(sb, tag, writeTag = false) {
        if (this.currentComments.has(tag)) {
            if (writeTag) {
                sb.append(tag + ' ');
            }
            const text = this.currentComments.get(tag);
            sb.append(text);
            return true;
        }
        else {
            return false;
        }
    }
    /**
     * // TODO: comment _emitDescriptionHeader
     * Emits description header
     * @param sb
     * @param node
     */
    _emitDescriptionHeader(sb, node) {
        const name = utils.findFirstChildOfKindDepthFirst(node, [ts.SyntaxKind.Identifier]).getText();
        if (this.updateWithCurrentComments()) {
            this._emitMap(sb, 'TODO:', true);
            sb.appendLine();
        }
        else {
            // todo only for new comments
            this._emitToDo(sb, name);
        }
        if (vs.workspace.getConfiguration().get('comment-ts.includeDescriptionTag', false)) {
            sb.append('@description ');
        }
        if (!this._emitMap(sb, '@description')) {
            this._emitDescription(sb, node, name);
        }
        sb.appendLine();
    }
    _emitAuthor(sb) {
        if (vs.workspace.getConfiguration().get('comment-ts.includeAuthorTag', false)) {
            let author = vs.workspace.getConfiguration().get('comment-ts.authorName', '');
            sb.append('@author ' + author);
            // sb.appendSnippetTabstop();
            sb.appendLine();
        }
    }
    _emitVariableDeclaration(sb, node, sourceFile) {
        for (const child of node.getChildren()) {
            const result = this._documentNode(sb, child, sourceFile);
            if (result) {
                return result;
            }
        }
        return;
    }
    _emitFunctionExpression(sb, node, sourceFile) {
        let targetNode = node.parent;
        if (node.parent.kind !== ts.SyntaxKind.PropertyAssignment &&
            node.parent.kind !== ts.SyntaxKind.BinaryExpression &&
            node.parent.kind !== ts.SyntaxKind.PropertyDeclaration) {
            targetNode = utils.findFirstParent(targetNode, [
                ts.SyntaxKind.VariableDeclarationList,
                ts.SyntaxKind.VariableDeclaration
            ]);
            if (!targetNode) {
                return;
            }
        }
        this._emitDescriptionHeader(sb, node);
        this._emitTypeParameters(sb, node);
        this._emitParameters(sb, node);
        this._emitReturns(sb, node);
        return ts.getLineAndCharacterOfPosition(sourceFile, targetNode.getStart());
    }
    _emitClassDeclaration(sb, node) {
        this._emitDescriptionHeader(sb, node);
        // if (node.name) {
        //   sb.append(` ${node.name.getText()}`);
        // }
        this._emitAuthor(sb);
        // sb.appendLine();
        // this._emitHeritageClauses(sb, node);
        this._emitTypeParameters(sb, node);
    }
    _emitPropertyDeclaration(sb, node) {
        this._emitDescriptionHeader(sb, node);
        // if (node.kind === ts.SyntaxKind.GetAccessor) {
        //   const name = utils.findFirstChildOfKindDepthFirst(node, [ts.SyntaxKind.Identifier]).getText();
        //   const parentClass = <ts.ClassDeclaration>node.parent;
        // let hasSetter = !!parentClass.members.find(
        //   (c) =>
        //     c.kind === ts.SyntaxKind.SetAccessor &&
        //     utils.findFirstChildOfKindDepthFirst(c, [ts.SyntaxKind.Identifier]).getText() === name
        // );
        // }
    }
    _emitInterfaceDeclaration(sb, node) {
        this._emitDescriptionHeader(sb, node);
        this._emitAuthor(sb);
        // this._emitModifiers(sb, node);
        // sb.appendLine(`@interface ${ node.name.getText() }`);
        // this._emitHeritageClauses(sb, node);
        this._emitTypeParameters(sb, node);
    }
    _emitEnumDeclaration(sb, node) {
        this._emitDescriptionHeader(sb, node);
        // this._emitModifiers(sb, node);
        // sb.appendLine(`@enum `);
    }
    _emitMethodDeclaration(sb, node) {
        this._emitDescriptionHeader(sb, node);
        this._emitAuthor(sb);
        // this._emitModifiers(sb, node);
        this._emitTypeParameters(sb, node);
        this._emitParameters(sb, node);
        this._emitReturns(sb, node);
    }
    /**
     * Emits returns
     * @param sb
     * @param node
     */
    _emitReturns(sb, node) {
        if (utils.findNonVoidReturnInCurrentScope(node) || (node.type && node.type.getText() !== 'void')) {
            sb.append('@returns ');
            if (!this._emitMap(sb, '@returns')) {
                const parseNames = vs.workspace.getConfiguration().get('comment-ts.parseNames', true);
                if (node.type && parseNames) {
                    const methodname = utils.separateCamelcaseNounString(node.name.getText());
                    switch (node.type.getText()) {
                        case 'boolean': {
                            sb.append(`true if ${methodname}`);
                            break;
                        }
                        case 'Date': {
                            sb.append(`date of ${methodname}`);
                            break;
                        }
                        default: {
                            sb.append(`${methodname}`);
                            break;
                        }
                    }
                }
                sb.append(' ');
            }
            sb.appendSnippetTabstop();
            sb.appendLine();
        }
    }
    _emitParameters(sb, node) {
        if (!node.parameters) {
            return;
        }
        node.parameters.forEach((parameter) => {
            const name = parameter.name.getText();
            const isOptional = parameter.questionToken || parameter.initializer;
            sb.append('@param ');
            if (isOptional) {
                sb.append('[');
            }
            sb.append(name);
            if (isOptional) {
                sb.append(']');
            }
            sb.append(' ');
            this._emitMap(sb, name);
            sb.appendSnippetTabstop();
            sb.appendLine();
        });
    }
    /**
     * Emits constructor declaration
     * @param sb
     * @param node
     */
    _emitConstructorDeclaration(sb, node) {
        const className = node.parent.name.getText();
        sb.appendSnippetPlaceholder(`Creates an instance of ${utils.separateCamelcaseString(className)}.`);
        sb.appendLine();
        this._emitAuthor(sb);
        this._emitParameters(sb, node);
    }
    _emitTypeParameters(sb, node) {
        if (!node.typeParameters) {
            return;
        }
        node.typeParameters.forEach((parameter) => {
            sb.append(`@template ${parameter.name.getText()} `);
            sb.appendSnippetTabstop();
            sb.appendLine();
        });
    }
    /**
     * // TODO: comment dispose
     * Disposes documenter
     */
    dispose() {
        if (this._outputChannel) {
            this._outputChannel.dispose();
        }
        this._services.dispose();
    }
}
exports.Documenter = Documenter;
//# sourceMappingURL=documenter.js.map