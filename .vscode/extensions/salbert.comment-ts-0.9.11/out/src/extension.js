"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vs = require("vscode");
const documenter_1 = require("./documenter");
const codegen_1 = require("./codegen");
const progLanguages = ['typescript', 'typescriptreact'];
let documenter;
function lazyInitializeDocumenter() {
    if (!documenter) {
        documenter = new documenter_1.Documenter();
    }
}
function languageIsSupported(document) {
    return progLanguages.findIndex((l) => document.languageId === l) !== -1;
}
function verifyLanguageSupport(document, commandName) {
    if (!languageIsSupported(document)) {
        vs.window.showWarningMessage(`Sorry! '${commandName}' only supports TypeScript.`);
        return false;
    }
    return true;
}
function runCommand(commandName, document, implFunc) {
    if (!verifyLanguageSupport(document, commandName)) {
        return;
    }
    try {
        lazyInitializeDocumenter();
        implFunc();
    }
    catch (e) {
        debugger;
        console.error(e);
    }
}
// Thanks, @mjbvz!
class DocThisCompletionItem extends vs.CompletionItem {
    constructor(document, position) {
        super('/** Comment... */', vs.CompletionItemKind.Snippet);
        this.insertText = '';
        this.sortText = '\0';
        this.kind = vs.CompletionItemKind.Snippet;
        const line = document.lineAt(position.line).text;
        const prefix = line.slice(0, position.character).match(/\/\**\s*$/);
        const suffix = line.slice(position.character).match(/^\s*\**\//);
        const start = position.translate(0, prefix ? -prefix[0].length : 0);
        this.range = new vs.Range(start, position.translate(0, suffix ? suffix[0].length : 0));
        this.command = {
            title: 'Comment...',
            command: 'comment-ts.commentThis',
            arguments: [true]
        };
    }
}
function activate(context) {
    context.subscriptions.push(vs.languages.registerCompletionItemProvider(progLanguages, {
        provideCompletionItems: (document, position, token) => {
            const line = document.lineAt(position.line).text;
            const prefix = line.slice(0, position.character);
            if (prefix.match(/^\s*$|\/\*\*\s*$|^\s*\/\*\*+\s*$/)) {
                return [new DocThisCompletionItem(document, position)];
            }
            return;
        }
    }, '/', '*'));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.constructor', () => {
        const classesListBoth = codegen_1.generateClassesList(codegen_1.EType.BOTH);
        codegen_1.generateCode(classesListBoth, codegen_1.EType.CONSTRUCTOR);
    }));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.interface', () => {
        const classesListBoth = codegen_1.generateClassesList(codegen_1.EType.BOTH);
        codegen_1.generateCode(classesListBoth, codegen_1.EType.INTERFACE);
    }));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.commentThis', (forCompletion) => {
        const commandName = 'Comment...';
        runCommand(commandName, vs.window.activeTextEditor.document, () => {
            documenter.commentThis(vs.window.activeTextEditor, commandName, forCompletion);
        });
    }));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.getter', function () {
        const classesListGetter = codegen_1.generateClassesList(codegen_1.EType.GETTER);
        vs.window.showQuickPick(codegen_1.quickPickItemListFrom(classesListGetter, codegen_1.EType.GETTER)).then((pickedItem) => {
            codegen_1.generateCode(classesListGetter, codegen_1.EType.GETTER, pickedItem);
        });
    }));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.setter', function () {
        const classesListSetter = codegen_1.generateClassesList(codegen_1.EType.SETTER);
        vs.window.showQuickPick(codegen_1.quickPickItemListFrom(classesListSetter, codegen_1.EType.SETTER)).then((pickedItem) => {
            codegen_1.generateCode(classesListSetter, codegen_1.EType.SETTER, pickedItem);
        });
    }));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.allGetterAndSetter', function () {
        const classesListGetter = codegen_1.generateClassesList(codegen_1.EType.GETTER);
        const classesListSetter = codegen_1.generateClassesList(codegen_1.EType.SETTER);
        codegen_1.generateAllGetterAndSetter(classesListGetter, classesListSetter);
    }));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.getterAndSetter', function () {
        const classesListBoth = codegen_1.generateClassesList(codegen_1.EType.BOTH);
        vs.window.showQuickPick(codegen_1.quickPickItemListFrom(classesListBoth, codegen_1.EType.BOTH)).then((pickedItem) => {
            codegen_1.generateCode(classesListBoth, codegen_1.EType.BOTH, pickedItem);
        });
    }));
    context.subscriptions.push(vs.commands.registerCommand('comment-ts.traceTypeScriptSyntaxNode', () => {
        const commandName = 'Trace Typescript Syntax Node';
        runCommand(commandName, vs.window.activeTextEditor.document, () => {
            documenter.traceNode(vs.window.activeTextEditor);
        });
    }));
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map