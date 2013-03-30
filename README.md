# Slim Text

Slim Text is a Slim Text editor which runs inside a web browser.


## priority items

easy first, hard last, no hurry!


## todo list

68. auto detect file change outside of the editor and load the newest content into editor
    1. advanced feature, postpone
97. enable ace editor features:
    1. remove trailing spaces upon saving
        1. some one hate trailing spaces a lot!
    2. add new line to the end of file upon saving
    4. auto complete
    5. it seems that I have to implment those features myself, ace doesn't provide such features.
104. minor bug: unsaved content, refresh page, page title changed to "chrome-extension://...."
    1. if the title does not start with "* ", is OK
    2. I think it is a bug of chrome
105. introduce plugin system
    1. page actions, to change the appearance or behavior of the software, such as change background, such as define new shortcut key 
    2. advanced feature, postpone
    3. is it viable and practical?
111. bug: windows 7 C: / Windows / System32 / drivers, can not see the etc/ folder
    1. and a lot of *.sys files are invisible too.
    2. notepad++ has this issue too
112. bug: slow when open windows 7 C: / Windows / System32
    1. caused by underscorejs filter method?
118. should be able to open a folder quickly.
    1. for example, register a folder as a button, and click that button.
    2. register workspace, quick open
        1. open recent files or folders?
125. launch via command line, such as subl . &
133. open a new tab, default path is the current tab's path?
    1. the same as ubuntu terminal
135. go through this page: http://ace.ajax.org/#nav=production
137. listen to backspace keyboard event and open the last folder?
    1. but editor also need this event. do experiments
140. add command line
    1. gcli: https://github.com/mozilla/gcli
    2. research, find the best solution!
141. Chinese name 思灵编辑器 ?
    1. 四死私似思斯司丝驷
    2. 零另令灵领玲凌玲聆伶
    3. no hurry, postpone
    4. 要普通中国人接受这个编辑器，必须得有中文名!
142. add increase font-size or decrease font-size to menu ?
    1. and persist locally
    2. when open the editor, first check local storage, then check sync storage, and then last storage. Use the first one found.
157. bug: searchbox too weak, can not specify case-sensitive and regex search
158. chrome history api to go back to last folder?
    1. I think use history api for quick file open is possible. can do free form searching
160. bootstrap Typeahead can replace omnibox
161. a viable quick open solution: 
    1. everyting time open a folder, add the files in the folder into chrome.history
    2. ctrl + P show a input box
    3. use chrome history search to search
    4. bootstrap typeahead to show candidates
    5. select a candidate to open
162. Preview markdown: https://gist.github.com/4670615
163. cvanalyze.com click qq icon can launch qq, investigate
166. spell check (it is an ext of Ace)
169. 这篇文章不错： http://www.ibm.com/developerworks/library/os-extendchrome/index.html
172. differentiate states for some operations
    1. such as show/hide invisibles, two states: show invisibles and hide invisibles
176. compress html files before deployment
177. bug: Emacs ctrl + n conflicts with chrome create a new windows
    1. if I am an Emacs user, I feel quite annoying
182. remove file/folder
183. rename file/folder
184. minor bug: right after installation, the path for windows is backslash instead of slash
    1. problem resolved if you click any path
186. Minor bug: save a new file, the file on left panel does not appear as white color
187. can not be installed on win8!
    1. this application is not supported on this computer. Installation has been disabled
    2. it is said that run chrome in win7 compatible mode can resolve this issue
    3. install win8 and do testing
    4. write instructions for win8 users
188. hidden files, useless files such as *.pyc
    1. some body said that they didn't want to see them
    2. combine this feature together with show invisibles quick button?
191. update the website once standalone version is ready
192. create chrome packaged app version?
    1. there are issue: jquery ui layout does not run in chrome packaged app
        1. packaged app does not support unload event
        2. but I can create the app wihout jquery ui layout
    2. can not list a folder. only file dialog available. 
        1. user have to open a dialog each time he wants to open a file
        2. So NPAPI is still needed
    3. already have chrome extension version and Qt version
    4. at least two uses request this
    5. but I cannot see the value. there is no major advantages.
194. file content encode issue on windows
    1. create a text file, contains Chinese characters. The file encoding is ANSI by default
    2. open in Slim Text, Chinese characters are unreadable
    3. bug: chinese encoding decoding issue for C:/QQDownload/From Tyler/01.htm
    4. bug: windows csharp file, show BOM as * (because cannot handle utf8 with BOM)
200. bug: cannot see mounted external dirves in windows. such as virtualbox shared folder
202. Preview HTML
203. hide address bar
205. does not support Ubuntu 10.04 32-bit or 64-bit
206. save all
211. two many files opened, tabs bar not enough space to hold them
212. context menu: https://github.com/medialize/jQuery-contextMenu
213. bug: window switch dirves
214. drag & drop tabs
    1. jqueryui sortable kind of buggy
215. 


## won't fix

1. bug: refresh page before desktop notification closes, the notification never closes
    1. cannot dismiss the notification window upon refreshing, this is a bug of chrome, so postpone
        1. https://code.google.com/p/chromium/issues/detail?id=40262
2.
