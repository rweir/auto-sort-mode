# auto-sort-mode

A minor mode for automatically sorting a portion of a file, delimited like this:

```text
some unsorted text

<!-- { sort-start } -->
a
b
c
d
<!--{ sort-end } -->

other unsorted text
```

The delimiters were chosen to match those of the VSCode extension [Scoped Sort](https://marketplace.visualstudio.com/items?itemName=karizma.scoped-sort).

Enabling the minor mode automatically sorts the lines between the delimiters on save.

## Ad hoc sorting

The package also provides an `interactive` function `(sort-between-delimiters)` that can be run whenever.

## Enabling via file vars

To have Emacs apply this minor mode to a file on open, add a line like at the top of the file (or use the separate syntax for the bottom):

```text
# -*- eval: (auto-sort-mode 1); -*-
```

(see the Emacs [docs](https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Variables.html) for more info).
