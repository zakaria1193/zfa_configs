## Windows:

CTRL-W O > close all windows but the current one
CTRL-W x > Switch current window with the next one
CTRL-W + > Increase height of current window
CTRL-W - > Decrease height of current window
CTRL-W = > Equalize height of all windows
Ctrl-W H > make current window full height at far left (leftmost vertical window)
Ctrl-W L > make current window full height at far right (rightmost vertical window)
Ctrl-W J > make current window full width at the very bottom (bottommost horizontal window)
Ctrl-W K > make current window full width at the very top (topmost horizontal window)

## Registers:
In insert more or commande mode:
CTRL-R 2 > Insert the content of register 2

## In normal mode:
@2 > Execute the content of register 2
"2p > paste the content of register 2
"2y > yank the current line to register 2

## Special registers:
"" > last yanked or cut text (unnamed register)
"0 > Last deleted text
"1 > First deleted text
"2 > Second deleted text
...

". > Last inserted text
"% > Current file name
"# > Alternate file name
"/ > Last search pattern
": > Last command line
"= > Last expression (you enter an expression in the command line)

"+ > system clipboard (copy on select, paste on molette)
"* > system clipboard (ctrl C ctrl V)

"[a-zA-Z] > user registers, macros go here

## Marks
:marks   - list of marks
ma       - set current position for mark A
:delm a  - delete mark A
`a       - jump to position of mark A
y`a      - yank text to position of mark A
`0       - go to the position where Vim was previously exited
`"       - go to the position when last editing this file
`.       - go to the position of the last change in this file
``       - go to the position before the last jump

User marks can be from a to z for file local marks
and A to Z for global marks. (They're both stored in .viminfo like registers)

:ju[mps] - list of jumps
Ctrl + i - go to newer position in jump list
Ctrl + o - go to older position in jump list

:changes - list of changes
g,       - go to newer position in change list
g;       - go to older position in change list

Ctrl + ] - jump to the tag under cursor


## Text objects

aw – a word (includes surrounding white space)
iw – inner word (does not include surrounding white space)

as – a sentence
is – inner sentence

ap – a paragraph
ip – inner paragraph

a” – a double quoted string
i” – inner double quoted string
a’ – a single quoted string
i’ – inner single quoted string
a` – a back quoted string
i` – inner back quoted string

a) – a parenthesized block
i) – inner parenthesized block

## EasyAlign
ga key in visual mode, or ga followed by a motion or a text object to start interactive mode
(Optional) <Enter> key to cycle between alignment mode (left, right, or center)
(Optional) N-th delimiter (default: 1):
            1  Around the 1st occurrences of delimiters
            2  Around the 2nd occurrences of delimiters
            *  Around all occurrences of delimiters
            ** Left-right alternating alignment around all delimiters
            -  Around the last occurrences of delimiters (-1)
            -2 Around the second to last occurrences of delimiters

Examples
vipga=
 - visual-select inner paragraph then Align around =
gaip*=
 - Align around all occurences of = in inner paragraph


Delimiter key (a single keystroke; <Space>, =, :, ., |, &, #, ,) or an arbitrary regular expression after <CTRL-X>

### Options available in interactive mode:
Key     	 Option           	 Values
CTRL-F  	 filter           	 Input string ([gv]/.*/?)
CTRL-I  	 indentation      	 shallow, deep, none, keep
CTRL-L  	 left_margin      	 Input number or string
CTRL-R  	 right_margin     	 Input number or string
CTRL-D  	 delimiter_align  	 left, center, right
CTRL-U  	 ignore_unmatched 	 0, 1
CTRL-G  	 ignore_groups    	 [], ['String'], ['Comment'], ['String', 'Comment']
CTRL-A  	 align            	 Input string (/[lrc]+\*{0,2}/)
<Left>  	 stick_to_left    	 { 'stick_to_left': 1, 'left_margin': 0 }
<Right> 	 stick_to_left    	 { 'stick_to_left': 0, 'left_margin': 1 }
<Down>  	 *_margin         	 { 'left_margin': 0, 'right_margin': 0 }
