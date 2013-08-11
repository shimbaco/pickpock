chrome.browserAction.onClicked.addListener (tab) ->
  _consumerKey = '17342-886441b1370ebdcaa519f57f'

  if localStorage.accessToken
    url = 'https://getpocket.com/v3/get'

    $.ajax(
      type: 'POST'
      url: url
      headers:
        'X-Accept': 'application/json'
      data:
        consumer_key: _consumerKey
        access_token: localStorage.accessToken
        state: 'unread'
      dataType: 'json'
    ).done (data) ->
      window.pages = data.list
      keys = _.keys(pages)
      pickedKey = _.first(_.shuffle(keys))

      if pickedKey
        url = 'https://getpocket.com/v3/send?' +
              "actions=[{\"action\":\"archive\",\"item_id\":#{pickedKey}}]&" +
              "access_token=#{localStorage.accessToken}&" +
              "consumer_key=#{_consumerKey}"
        $.ajax(
          type: 'POST'
          url: url
          headers:
            'X-Accept': 'application/json'
          dataType: 'json'
        ).done (data) ->
          open(pages[pickedKey].given_url)
      else
        alert 'Your Queue Is Empty'
