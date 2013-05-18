# todo list

68. auto detect file change outside of the editor and load the newest content into editor
    2. save timestamp everytime saving a file
        1. get the time via boost api?
    4. listen to tab focus event, check the file status
        1. if file is removed, confirm the user whether want to remove it
        2. check last\_mod\_time, if newer, confirm the user to relad it
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
    2. if already have a window, then no need to open all of the files, just navigate to folder path ?
140. add command line
    1. gcli: https://github.com/mozilla/gcli
    2. research, find the best solution!
160. bootstrap Typeahead can replace omnibox
161. a viable quick open solution:
    1. everyting time open a folder, add the files in the folder into chrome.history
    2. ctrl + P show a input box
    3. use chrome history search to search
    4. bootstrap typeahead to show candidates
    5. select a candidate to open
163. cvanalyze.com click qq icon can launch qq, investigate
166. spell check (it is an ext of Ace)
169. 这篇文章不错： http://www.ibm.com/developerworks/library/os-extendchrome/index.html
172. differentiate states for some operations
    1. such as show/hide invisibles, two states: show invisibles and hide invisibles
176. compress html files before deployment
177. bug: Emacs ctrl + n conflicts with chrome create a new windows
    1. if I were an Emacs user, I would feel quite annoying
182. remove/rename file/folder
    1. show remove/rename icons on the left panel whenever mouse over
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
    4. at least two users request this
    5. but I cannot see the value. there is no major advantages.
194. file content encode issue on windows
    1. create a text file, contains Chinese characters. The file encoding is ANSI by default
    2. open in Slim Text, Chinese characters are unreadable
    3. bug: chinese encoding decoding issue for C:/QQDownload/From Tyler/01.htm
    4. bug: windows csharp file, show BOM as * (because cannot handle utf8 with BOM)
200. bug: cannot see mounted external dirves in windows. such as virtualbox shared folder
202. Preview HTML
211. two many files opened, tabs bar not enough space to hold them
212. context menu: https://github.com/medialize/jQuery-contextMenu
    1. rename, delete
214. drag & drop tabs
    1. jqueryui sortable kind of buggy
216. popup window task bar icon too small on windows
    1. chrome's bug, postpone: https://code.google.com/p/chromium/issues/detail?id=94301
218. remember the current active tab
221. disable status bar when hover on tabs
    1. no easy way
    2. a possible solution: remove href upon hovering, add href back upon clicking. save href value in data attr
230. increase tab panel size dynamically if too many files opened
231. investigate how to write ext
    1. take ext-whitespace as an example
232. auto complete
233. write 'tips of the day' page
234. learn js export and require
235. mode specific menu
    1. for example: when markdown mode, show a new "markdown menu", with "preview" option inside
236. Refactor code
237. write tests
    1. how to test?
238. preview HTML?
