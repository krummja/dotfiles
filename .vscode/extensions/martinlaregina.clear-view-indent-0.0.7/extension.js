// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode');

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed

/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {

	// Use the console to output diagnostic information (console.log) and errors (console.error)
	// This line of code will only be executed once when your extension is activated
	//console.log('Congratulations, your extension "clear-view-indent" is now active!');

	// The command has been defined in the package.json file
	// Now provide the implementation of the command with  registerCommand
	// The commandId parameter must match the command field in package.json
	let disposable = vscode.commands.registerCommand('extension.clearViewIndent', function () {
		// The code you place here will be executed every time your command is executed

		// Display a message box to the user
		//vscode.window.showInformationMessage('Muchas gracias por utilizar Clear View Indent !!!');

		// Display a message to the user into status bar
		const message = 'Thank you for use Clear View Indent !!! ( laregina@gmail.com )';
		const timeout = 2000;
		vscode.window.setStatusBarMessage(message, timeout);

		var editor = vscode.window.activeTextEditor;
		if (!editor) {
				vscode.window.setStatusBarMessage('Error', timeout);
				return; // No open text editor
		}

		var selection = editor.selection;
		var text      = editor.document.getText(selection);
		var res       = text.split("\n");
		var maxLength = 0;
		var output    = '';

		res.forEach(element => {
			var res1 = [];
			var tmp = element.split('=');
			res1.push(tmp.shift());
			res1.push(tmp.join('='));
			if ( res1.length !== 2 ) return;
			var key = res1[0].trim();
			var value = res1[1].trim();
			if ( value.substr(value.length - 1 ) !== ";" ) return;
			maxLength = maxLength < key.length ? key.length : maxLength;
		});

		if ( maxLength > 0 ){
			res.forEach(element => {
				var res1 = [];
				var tmp = element.split('=');
				res1.push(tmp.shift());
				res1.push(tmp.join('='));	
				if ( res1.length === 2 ){
					var key = res1[0].trim();
					var value = res1[1].trim();
					if ( value.substr(value.length - 1) === ";" ) {
						output = output.concat(key.padEnd(maxLength, ' ') + ' = ' + value + '\n');
					} else {
						output = output.concat(element + '\n');
					}
				} else {
					output = output.concat(element + '\n');
				}
			});
			editor.edit(builder => builder.replace(selection, output));
		}

		//console.log(output);

	});

	context.subscriptions.push(disposable);

}

exports.activate = activate;

// this method is called when your extension is deactivated
function deactivate() {}


module.exports = {
	activate,
	deactivate
}
