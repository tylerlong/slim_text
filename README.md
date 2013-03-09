# Slim Text

Slim Text is a Slim Text editor which runs inside a web browser.


## priority items

easy first, hard last, no hurry!
170


## todo list

68. auto detect file change outside of the editor and load the newest content into editor
    1. advanced feature, postpone
85. windows bug: does not support chinese characters in path
    1. ubuntu OK, Mac OK
    2. windows 7 list result does not contain Chinese folders or files at all
    3. windows xp show Chinese folders as drunk codes, can not list the folder and can not open file
86. bug: chinese encoding decoding issue for C:/QQDownload/From Tyler/01.htm
90. Support tabs(inside the same chrome tab window)?
    1. there is tab example in the jquery ui layout project
    2. will not support this feature in version 0.0.1, postpone
93. bug: if current focus is not the editor window, ctrl + s does not work
    1. use chrome extension to listen this keyboard event?
96. bug: windows csharp file, show BOM as *
97. enable ace editor features:
    1. remove trailing space upon saving
    2. add new line to the end of file upon saving
    4. auto complete
99. marketing
    4. upload promotion images to chrome web store
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
118. should be able to open a folder quickly.
    1. for example, register a folder as a button, and click that button.
    2. register workspace, quick open
        1. open recent files or folders?
120. design omnibox command set
    1. should be easy to remember and similiar to the ones used in linux, window and mac
123. do not need any omnibox keyword at all?
    1. google search does not need keyword at all, so it is technically possible
125. launch via command line, such as subl . &
132. infobar to issue commands? http://developer.chrome.com/extensions/experimental.infobars.html
    1. and for find and replace?
    2. and for create new files?
    3. problem: this feature is currently experimental, disabled by default unless user change some flag manually.
133. open a new tab, default path is the current tab's path?
    1. the same as ubuntu terminal
135. go through this page: http://ace.ajax.org/#nav=production
136. move ace into js folder?
137. listen to backspace keyboard event and open the last folder?
138. remove options page, move all the options to menu
    1. two categories of menu items: 
        1. one is temp ones which does not need to be persistent
        2. the other is permenant ones which should be stored into chrome.storage
        3. DRY, write code to handle all of the menu items, add new menu items should be easy.
139. refactor the code!!!
140. gcli: https://github.com/mozilla/gcli
141. Chinese name 思灵编辑器 ?
    1. 四死私似思斯司丝驷
    2. 零另令灵领玲凌玲聆伶
    3. no hurry, postpone
142. add increase font-size or decrease font-size to menu ?
151. split window?
  1. design this feature together with multiple tabs
155. can diable soft tab?
157. bug: searchbox too weak, can not specify case-sensitive and regex search
158. chrome history api to go back to last folder?
    1. I think use history api for quick file open is possible. can do free form searching
159. show folder path in address bar?
    1. should be able to open a file by enter address, otherwise it is confusing
160. bootstrap Typeahead can replace omnibox
161. a viable quick open solution: 
    1. everyting time open a folder, add the files in the folder into chrome.history
    2. ctrl + P show a input box
    3. use chrome history search to search
    4. bootstrap typeahead to show candidates
    5. select a candidate to open
162. Preview markdown: https://gist.github.com/4670615
163. cvanalyze.com click qq icon can launch qq, investigate
166. spell check
167. Text Drive 这个app可以直接读写本地的文件! 了解下是怎么做的！！！
    1. https://chrome.google.com/webstore/detail/text-drive/mmfbcljfglbokpmkimbfghdkjmjhdgbg
    2. 在我电脑上的目录： C:\Users\Tyler\AppData\Local\Google\Chrome\User Data\Default\Extensions\mmfbcljfglbokpmkimbfghdkjmjhdgbg\0.2.38_0
    3. 初步的了解， 它没有用NPAPI
    4. 貌似是因为app的缘故？ app的权限远大于extension？
        1. 正确来讲， 是packaged app的权限非常大。 这是个新东东， 不得不学。
    5. 我可以用这个推出桌面版的Slim Text？
168. 开发桌面版的Slim Text， 利用这里的技术： http://developer.chrome.com/apps/about_apps.html
169. 这篇文章不错： http://www.ibm.com/developerworks/library/os-extendchrome/index.html
170. add more toolbar icons
171. 


## won't fix

1. bug: refresh page before desktop notification closes, the notification never closes
    1. cannot dismiss the notification window upon refreshing, this is a bug of chrome, so postpone
        1. https://code.google.com/p/chromium/issues/detail?id=40262
2.
