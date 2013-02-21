chrome.browserAction.onClicked.addListener (tab) ->
  chrome.tabs.create { url: chrome.extension.getURL('html/editor.html') }
