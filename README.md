# Slim Text

Slim Text is a slim text editor which runs inside a web browser.


## todo list

4. register domain name slimtext.org ?
7. should be able to browse to open a folder or file
    1. should do GUI programming for win, mac and linux, not easy, postpone
10. i18n
    1. not priority, English support is enough at the moment
13. update the old editor_in_chrome project and tell the users that they should switch to this project.
    1. do this after publishing Slim Text to public
25. bug: breadcrumb emtpty if '/'
27. add ace as submodule?
29. add toolbar to the right of menu bar
33. add a "syntax" menu items to "view" menuitem
34. add clear cache action to options page
    1. reinstall the extension clears everything in chrome.storage
35. can define filters, do not show some kind of files
36. no need to show href in status bar, how to tell chrome not to do that?
    1. do not use <a>, use <span> and css it
37. remeber the status of layout
    1. testing: enter full window mode then refresh
38. multiple tabs, folder, file conflict.
    1. didn't consider multiple instance. should attach content to tab id and save into dict
    2. should store global variables in to windows.storage instead of chrome.storage
39. only save to chrome.storage upon window close
    1. global variables save into window.storage
40. user can use omnibox to issue commands
41. move current work env onto Slim Text
42.
