"use strict";
/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const vscode_1 = require("vscode");
const fs_1 = require("fs");
const vscode_languageclient_1 = require("vscode-languageclient");
let client;
function readVersion(extensionDir) {
    return fs_1.readFileSync(path.join(extensionDir, 'CLJ_KONDO_VERSION')).toString().trim();
}
function welcome(version) {
    return `-- Welcome to clj-kondo v${version}.
--
-- To configure clj-kondo, create a .clj-kondo directory in the root of your workspace and place a config.edn file in it.
-- Check out the configuration documentation here: https://github.com/borkdude/clj-kondo/blob/master/doc/config.md.
--
-- If you have questions, join the #clj-kondo channel on Clojurians slack.
-- Report issues at: https://github.com/borkdude/clj-kondo.
--
-- Happy linting!
`;
}
;
function activate(context) {
    const channel = vscode_1.window.createOutputChannel('clj-kondo');
    context.subscriptions.push(channel);
    // channel.show(true);
    // The debug options for the server
    // --inspect=6009: runs the server in Node's Inspector mode so VS Code can attach to the server for debugging
    let debugOptions = { execArgv: ['--nolazy', '--inspect=6009'] };
    let jarPath = path.join(context.extensionPath, 'clj-kondo.lsp-standalone.jar');
    let serverOptions = {
        run: { command: 'java', args: ['-jar', jarPath] },
        debug: { command: 'java', args: ['-jar', jarPath] },
    };
    // If the extension is launched in debug mode then the debug server options are used
    // Otherwise the run options are used
    // Options to control the language client
    let clientOptions = {
        // Register the server for plain text documents
        documentSelector: [{ scheme: 'file', language: 'clojure' }],
        outputChannel: channel
    };
    // Create the language client and start the client.
    client = new vscode_languageclient_1.LanguageClient('clj-kondo', 'clj-kondo', serverOptions, clientOptions);
    channel.appendLine(welcome(readVersion(context.extensionPath)));
    // Start the client. This will also launch the server
    context.subscriptions.push(client.start());
}
exports.activate = activate;
function deactivate() {
    if (!client) {
        return undefined;
    }
    return client.stop();
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map