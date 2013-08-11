(function() {
  chrome.browserAction.onClicked.addListener(function(tab) {
    var url, _consumerKey;
    _consumerKey = '17342-886441b1370ebdcaa519f57f';
    if (localStorage.accessToken) {
      url = 'https://getpocket.com/v3/get';
      return $.ajax({
        type: 'POST',
        url: url,
        headers: {
          'X-Accept': 'application/json'
        },
        data: {
          consumer_key: _consumerKey,
          access_token: localStorage.accessToken,
          state: 'unread'
        },
        dataType: 'json'
      }).done(function(data) {
        var keys, pickedKey;
        window.pages = data.list;
        keys = _.keys(pages);
        pickedKey = _.first(_.shuffle(keys));
        if (pickedKey) {
          url = 'https://getpocket.com/v3/send?' + ("actions=[{\"action\":\"archive\",\"item_id\":" + pickedKey + "}]&") + ("access_token=" + localStorage.accessToken + "&") + ("consumer_key=" + _consumerKey);
          return $.ajax({
            type: 'POST',
            url: url,
            headers: {
              'X-Accept': 'application/json'
            },
            dataType: 'json'
          }).done(function(data) {
            return open(pages[pickedKey].given_url);
          });
        } else {
          return alert('Your Queue Is Empty');
        }
      });
    }
  });

}).call(this);
