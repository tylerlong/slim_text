# Slim Text

Slim Text is a slim text editor which runs inside a web browser.


## priority items
99


## todo list

63. bug: refresh page before desktop notification closes, the notification never closes
    1. cannot dismiss the notification window upon refreshing, this is a bug of chrome, so postpone
        1. https://code.google.com/p/chromium/issues/detail?id=40262
66. get rid of options page, move the options to menu?
    1. move the options to menu!
    2. think again! think about the future: can I get rid of it for ever? or just currently?
68. auto detect file change outside of the editor and load the newest content into editor
    1. advanced feature, postpone
85. windows bug: does not support chinese characters in path
    1. ubuntu OK, Mac OK
    2. windows 7 list result does not contain Chinese folders or files at all
    3. windows xp show Chinese folders as drunk codes, can not list the folder and can not open file
86. bug: chinese encoding decoding issue for C:/QQDownload/From Tyler/01.htm
87. register workspace, quick open
    1. open recent files or folders?
90. Support tabs(inside the same chrome tab window)?
    1. there is tab example in the jquery ui layout project
    2. will not support this feature in version 0.0.1, postpone
92. ubuntu bug：Chinese input eats a character after cursor
    1. ubuntu has this problem
        1. maybe it is a bug of the ibus input program
        2. ace editor have this problem, report the bug to them!
    2. windows OK, Mac OK
93. bug: if current focus is not the editor window, ctrl + s does not work
96. bug: windows csharp file, show BOM as *
97. enable ace editor features:
    1. remove trailing space upon saving
    2. add new line to the end of file upon saving
    3. show invisible chars. (upon selection?)
    4. auto complete
99. marketing
    1. submit to oschina.net
        1. do they accept free but not os software?
    2. try to add a link to this page: http://ace.ajax.org/#nav=production
    3. update the old editor_in_chrome project and tell the users that they should switch to this project
        1. do this after publishing Slim Text to chrome web store, postpone
    4. upload promotion images to chrome web store
    5. do not do these until the product is resonably stable
104. minor bug: unsaved content, refresh page, page title changed to "chrome-extension://...."
    1. if the title does not start with "* ", is OK
    2. I think it is a bug of chrome
105. introduce plugin system
    1. page actions, to change the appearance or behavior of the software, such as change background, such as define new shortcut key 
    2. advanced feature, postpone
107. provide multiple themes and icons, the user can switch themes and icons
111. bug: windows 7 C: / Windows / System32 / drivers, can not see the etc/ folder
112. bug: slow when open windows 7 C: / Windows / System32
    1. caused by underscorejs filter method?
115. make all the icons padded?
116. change the filter algorithm, filter all binary files while keep all text files
118. should be able to open a folder quickly.
    1. for example, register a folder as a button, and click that button.
120. design omnibox command set
    1. should be easy to remember and similiar to the ones used in linux, window and mac
121. 
