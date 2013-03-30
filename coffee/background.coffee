chrome.browserAction.onClicked.addListener ->
    chrome.tabs.create { url: chrome.extension.getURL('html/main.html') }
    #chrome.windows.create { url: chrome.extension.getURL('html/main.html'), type: 'popup' }
