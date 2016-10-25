# DOSmag #

A '90s style [disk-zine](https://en.wikipedia.org/wiki/Disk_magazine) interface for viewing portable hyper-linked documents and content. Written in [QB64](http://www.qb64.net/); a modern remake of Microsoft's classic [QuickBASIC](https://en.wikipedia.org/wiki/QuickBASIC) IDE.

## How to Write Pages ##

The pages displayed by the DOSmag viewer reside in the "`pages`" folder. Each page is simply a txt file, but with the extension "`.dosmag`". This is so that you can set custom encoding / font options for this file-type in your text editor.

> _Pro Tip:_ Make sure files are always saved in ANSI encoding, not UTF-8! DOSmag displays text using [code page 437](https://en.wikipedia.org/wiki/Code_page_437), sometimes called "DOS" or "OEM-US" encoding. Open [CharMap](https://en.wikipedia.org/wiki/Character_Map_(Windows)) and set the font to Terminal to access the extra symbols. 

Pages can be grouped into sets. Such sets share the same file name, but are suffixed by the page number e.g. "`#04`". The number *must* be two digits long to be recognised. This ensures that the files appear ordered correctly on your drive.

Long lines will be word-wrapped for you, so it is best to just write each paragraph as a single continuous line and set your text-editor to word-wrap.

### Control Codes ###

Within a page file, these are the conventions you may use:

```
^C
```

A line that begins with `^C` will be centred. If the line is too long for the screen, it will wrap and all such lines will be centred too. The centre control code *must* appear as the first thing on a line, no other control code can preceed it.

```
^:
```

A heading. This effect continues for the rest of the line. (the colon is not printed)

```
^*...^*
```

A "bold" effect. The bold control code turns the effect on and then off each time it is encountered, however it automatically turns off at the end of a line. For example:

```
^*This text will be bold
^*And so will this!
```

This is why, in general, you should not manually word-wrap your text.

```
^/...^/
```

An "italic" effect. Behaves in the same manner as the bold control code.

```
^-
^=
```

These draw lines across the screen. These can only appear at the beginning of a line (they cannot co-exist with the centre control code), and everything after the first dash / equals is ignored. For example:

```
^:Heading 1
^----------
^:Heading 2
^==========
```

> Pro Tip: You can press F5 in DOSmag to reload the current page!

```
^( ... )
```

Parentheses can be highlighted this way. The effect will stop at the first closing parenthesis that follows. The control code will output the opening parenthesis for you.

```
^[...]
```

This is intended to markup navigation keys, such as "`[D]`". The opening square bracket will be displayed and the effect will continue until the next closing square bracket. There must not be any spaces between the square brackets.

NOTE: This does not actually bind the key to any action, it's purely a visual indicator. See below for how to bind keys to actions.

### Key Bindings ###

To make a key navigate to another page, place a key binding instruction at the top of your page. For example:

```
$KEY:D=GOTO:Name of a Page #01
```

The `$KEY:` text indicates a key binding. There must be no whitespace before it and these should appear on the first lines of your page. The next letter is the key to bind, 'A' - 'Z', '0' - '9'; must be capital.

After the equals sign, the word "GOTO:" indicates the action to take, i.e. navigate to a page. Give the name of the page set to load, and optionally, the page number if the page set has more than one.

The `SHELL:` action allows you to execute batch commands or open files stored in the "`files`" folder.

```
$KEY:W=SHELL:Watch This.ppt
```

In the case of batch commands, note that the 'current directory' will be set to the "`files`" folder.

```
$KEY:B=SHELL:some_batch_file.bat
```
