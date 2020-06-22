# Calva: Clojure & ClojureScript with Visual Studio Code

![Calva logo](https://raw.githubusercontent.com/BetterThanTomorrow/calva/dev/assets/calva-64h.png)

_Distilled from [CIDER](https://cider.mx/)*._

Welcome to [Calva](https://marketplace.visualstudio.com/items?itemName=betterthantomorrow.calva), an integrated REPL powered environment for enjoyable and productive [Clojure](https://clojure.org) and [ClojureScript](https://clojurescript.org) in [Visual Studio Code](https://code.visualstudio.com). It includes inline code evaluation, [Paredit](https://calva.io/paredit/), a Clojure formatter, a test runner, Clojure syntax highlighting, and more. Most of the REPL power is harvested from the produce of [The Orchard](https://github.com/clojure-emacs/orchard).

(*) Calva is short for Calvados, a liquid gifted to humanity from God.

## There is Documentation

Head over to https://calva.io/ to learn more about how to use Calva. The most important stuff would be:

* [Connect Calva to Your Project](https://calva.io/connect/) (TL;DR; Use **Jack in**.)
* [Quirks](https://calva.io/quirks/) (Yes, there are quirks.)
* [Paredit – a Visual Guide](https://calva.io/paredit/) (Clojure editing is for civilized people.)

## Why Calva?

From [The Tao of Calva](https://github.com/BetterThanTomorrow/calva/wiki):

> Calva's _raison d´être_ is to provide Visual Studio Code users with an easy to use and productive environment for [Clojure](https://www.clojure.org) and [ClojureScript](https://clojurescript.org) development.

From the same page you can also learn that we want Calva to be a good choice for VS Code users asking:

> _How do I use my favorite code editor for Clojure development?_

We also hope that Calva will contribute to making it easier to pick up Clojure as a new language.

## Getting Started with Calva

Go to the [documentation](https://calva.io/) to find info on how to connect Calva to your project and start evaluating code and such. The documentation is built from the same repository as Calva. So if you know about workarounds or gotchas or anything that is good to know about when using Calva, please edit the appropriate page (or create a new page) by PR.

## Features

* Syntax highlighting, plus:
  * Rainbow parens
  * Rainbow indent guides
  * Highlight active indent guide
  * Highlights misplaced brackets
  * LISP friendly bracket matching
  * Ignore form (`#_`) dimming and `(comment)` form highlighting
* Code formatting and autoindent according to https://github.com/bbatsov/clojure-style-guide
* Structural Editing (via [Paredit](https://calva.io/paredit/))
* [Linting](https://calva.io/linting/)
* Intellisense
* Go to / Peek at definition
* View doc strings on hover
* View function signatures on hover, including help with knowing which argument you are typing
* [Debugger](https://calva.io/debugger/)
* Support for [Clojure tools/deps](https://clojure.org/guides/deps_and_cli), [Leiningen](https://leiningen.org), [shadow-cljs](http://shadow-cljs.org), [lein-figwheel](https://github.com/bhauman/lein-figwheel), and [Figwheel Main](https://figwheel.org), and Nashorn repls. (For [Boot](https://boot-clj.com), only Connect scenarios work, there is no Jack-in yet.)
* Your [Custom Connect Sequences](https://calva.io/connect-sequences/), including fully customized CLJS REPLs.
* Switch the CLJS REPL connection between your different CLJS builds at will.
* When editing `cljc` files, easily choose if REPL commands should go to the `clj` or `cljs` REPL by clicking the `cljc/clj[s]` indicator in the status bar.
* And more

### Demo: Evaluate top level forms inside `(comment...)`

![Top level comment eval](https://github.com/BetterThanTomorrow/calva/raw/master/assets/howto/top-level-comment-eval.gif)

The gif demos several more features, apart from the in-comment evaluation, like:

* signature help while typing function calls
* evaluation result display is a bit sticky (so you can examine several evaluations at once)
* there is a richer display of results in the hover of the evaluated expression. (From where you can also copy the results to the clipboard)
* some [structural editing](https://calva.io/paredit/)

### Demo: Signature Help, while Typing

It is pretty educational using the signature help hover to see which argument you are typing when the argument list is using destructuring, or when an argument is threaded in first before the arguments you provide inside the form.

![Signature Help](https://github.com/BetterThanTomorrow/calva/raw/master/assets/howto/signature-help.gif)

### Demo: Syntax highlighting, rainbow parens and guides

![Dimming ignored forms](https://github.com/BetterThanTomorrow/calva/raw/master/assets/howto/rainbow-guides.gif)

### Demo: Syntax highlighting, dimming ignored forms

![Dimming ignored forms](https://github.com/BetterThanTomorrow/calva/raw/master/assets/howto/dimming-ignores.gif)

### Demo: Peek at definitions, etcetera

![Features](https://github.com/BetterThanTomorrow/calva/raw/master/assets/howto/features.gif)

### Demo: switch between `clj` and `cljs` repl sessions for `cljc` files

![CLJC repl switching](https://github.com/BetterThanTomorrow/calva/raw/master/assets/howto/cljc-clj-cljs.gif)

## How to contribute

I'm glad you are reading this section! There are many ways and you are welcome to combine them at will. Be creative 😄:

* Give us feedback.
  * Via [#calva](https://clojurians.slack.com/messages/calva/) at the Clojurians Slack.
  * Via filing issues.
* Fix issues. PRs welcome! Calva is built using a combination of TypeScript and ClojureScript. The ClojureScript part uses the [shadow-cljs](http://shadow-cljs.org) tool chain. See the [How to Contribute](https://github.com/BetterThanTomorrow/calva/wiki/How-to-Contribute) page on the wiki for instructions on how to hack on Calva. TL;DR _It is super easy to get started!_
* Fix typos. In the UI and in the docs. It might seem like a small enough thing to not bother about it, but really, typos get in the way of comprehension. Typos are bad, uhm?
* Become a GitHub sponsor. Read on.

## Calva Sponsors ❤️

A considerable amount of time, creativity, energy, worries, sweat, and tears (well, no tears, but anyway 😄), is being spent on Calva. Please consider sponsoring us to show us that extra level of appreciation. Here are the ways you can do it:

* [Peter Strömberg's GitHub Sponsors Profile](https://github.com/sponsors/PEZ)

Yeah, it's the only way right now, hopefully the other team members are setting up sponsoring as well.

These people are helping to keep Calva maintained and improved by sponsoring with their hard earned money. It is fantastic. Thank you!


### Calva Gold Sponsors

_Companies that benefit from Calva's existence and see it as an important piece of the Clojure and ClojureScript ecosystem._

[<img src="https://liftoff.io/wp-content/themes/liftoff/images/logo-blue.png" height="30px" alt="Liftoff"/>](https://liftoff.io)

Gold sponsors are also displayed here: https://calva.io/#sponsors.

### Calva Fans

[<img src="https://avatars0.githubusercontent.com/u/103882" width="32" alt="Bozhidar Batsov">](https://github.com/bbatsov)
[<img src="https://avatars0.githubusercontent.com/u/133385" width="32" alt="Adam Feldman">](https://github.com/adamfeldman)
[<img src="https://avatars2.githubusercontent.com/u/585191" width="32" alt="Pedro Girardi">](https://github.com/pedrorgirardi)
[<img src="https://avatars2.githubusercontent.com/u/6115204" width="32" alt="Clay Hopperdietzel">](https://github.com/Gnurdle)
[<img src="https://avatars2.githubusercontent.com/u/891" width="32" alt="Matthew Lyon">](https://github.com/mattly)
[<img src="https://avatars0.githubusercontent.com/u/636651" width="32" alt="Brian Scaturro">](https://github.com/brianium)
[<img src="https://avatars0.githubusercontent.com/u/95657" width="32" alt="Steven Harms">](https://github.com/sharms)

### Calva Friends

[<img src="https://avatars3.githubusercontent.com/u/97496" width="32" alt="Martin Klepsch">](https://github.com/martinklepsch)
[<img src="https://avatars1.githubusercontent.com/u/1461719" width="32" alt="Byron Miller">](https://github.com/supernovae)
[<img src="https://avatars2.githubusercontent.com/u/6209" width="32" alt="Terje">](https://github.com/terjesb)
[<img src="https://avatars0.githubusercontent.com/u/11434205" width="32" alt="JC">](https://github.com/dijonkitchen)
[<img src="https://avatars1.githubusercontent.com/u/13815" width="32" alt="Ullrich Schäfer">](https://github.com/stigi)
[<img src="https://avatars3.githubusercontent.com/u/703980" width="32" alt="Scott Archer">](https://github.com/scarcher2)
[<img src="https://avatars0.githubusercontent.com/u/3316334" width="32" alt="Norman Eckstein">](https://github.com/ITSecMedia)
[<img src="https://avatars0.githubusercontent.com/u/1081640" width="32" alt="David Brear">](https://github.com/DavidBrear)
[<img src="https://avatars0.githubusercontent.com/u/19359748" width="32" alt="Sergei Udris">](https://github.com/sergeiudris)
[<img src="https://avatars1.githubusercontent.com/u/4200280" width="32" alt="Janne Sauvala">](https://github.com/sauvala)
[<img src="https://avatars1.githubusercontent.com/u/4172079" width="32" alt="Filipe Silva">](https://github.com/filipesilva)

## The Calva Team

We are Clojure and Visual Studio Code fans who care about the ergonomics of using our favorite programming language with our editor of choice.

### Current Maintainers

* [Peter Strömberg](https://github.com/PEZ)
* [Kevin Ahlbrecht](https://github.com/kstehn)
* [Christian Fehse](https://github.com/cfehse)
* [Brandon Ringe](https://github.com/bpringe)

### Alumni

* [Matt Seddon](https://github.com/mseddon)
* [Pedro Girardi](https://github.com/pedrorgirardi)
* [Stian Sivertsen](https://github.com/sivertsenstian) (Creator of Visual:Clojure)

### Code Contributors

Calva is a quite young open source project, with surprisingly many code contributors. We take great care to keep it easy and fun to contribute. See the [Calva Development Wiki](https://github.com/BetterThanTomorrow/calva/wiki) for more on this.

## Happy coding

We hope you will find good use for Calva. Please let us know what you think. PRs welcome, file an issue or chat us up in the [#calva](https://clojurians.slack.com/messages/calva/) channel in the Clojurians Slack.
