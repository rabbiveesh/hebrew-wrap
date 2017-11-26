This is hebrew.vim, a script for wrapping hebrew text in a latex
document.

We assume that the user has defined a command `\he` which is a
shortcut for `\texthebrew`.

This will probably break horribly if there's hebrew in math mode.
It also has some difficutly with colons at the end of a hebrew
word (which is a hard case anyway).
