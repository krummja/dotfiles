# Clear view indent

[![Visual Studio Marketplace](https://vsmarketplacebadge.apphb.com/installs-short/MartinLaRegina.clear-view-indent.svg?style=flat-square)](https://marketplace.visualstudio.com/items?itemName=MartinLaRegina.clear-view-indent)

This extension will help you see the code more clearly.
To use it once installed, select the code you wish to enter and then with the key combination "CTRL + Shift + P" type "Clear view indent" and press the Enter key

Before run:
```Java
final Actor actor = ModalRoute.of(context).settings.arguments;
final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
final Cines cines = ModalRoute.of(context).settings.arguments;
final Personajes personajes = ModalRoute.of(context).settings.arguments;
```

After run:
```Java
final Actor actor           = ModalRoute.of(context).settings.arguments;
final Pelicula pelicula     = ModalRoute.of(context).settings.arguments;
final Cines cines           = ModalRoute.of(context).settings.arguments;
final Personajes personajes = ModalRoute.of(context).settings.arguments;
```

## Features

What you do is to take the selected text and look for assignments, whether of variables or constants and indent them in a more orderly way for a clearer reading.

![Clear View Indent](https://bitbucket.org/laregina/clear-view-indent/raw/845b2b603199bdecc601dbb6eb750bd7942fffe6/clear-view-indent.gif)

## Requirements

Visual Studio Code

## Known Issues

Calling out known issues can help limit users opening duplicate issues against your extension.

## Release Notes

This is the first version of the Extension. Over time I will try to improve it and add new features

### 0.0.1

Initial release of Clear View Indent

### 0.0.2

Improve performance and fixes

### 0.0.3

Small fixes

### 0.0.4

Small fixes

### 0.0.5

Small fixes

### 0.0.6

Small fixes

### 0.0.7

Small fixes
