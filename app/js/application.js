(function() {
  $(function() {
    var Auth, template;
    Auth = (function() {
      var _consumerKey;

      _consumerKey = '17342-886441b1370ebdcaa519f57f';

      function Auth($el) {
        this.$el = $el;
        this.events();
        if ('?status=done' === location.search) {
          this.getAccessToken();
        }
      }

      Auth.prototype.events = function() {
        return this.$el.on('click', this.getRequestToken.bind(this));
      };

      Auth.prototype.getRequestToken = function() {
        var redirectUri, url,
          _this = this;
        redirectUri = location.href;
        url = 'https://getpocket.com/v3/oauth/request';
        return $.ajax({
          type: 'POST',
          url: url,
          data: {
            consumer_key: _consumerKey,
            redirect_uri: redirectUri
          }
        }).done(function(data) {
          var requestToken;
          requestToken = data.split('=')[1];
          localStorage.requestToken = requestToken;
          return _this.redirect(requestToken);
        });
      };

      Auth.prototype.redirect = function(requestToken) {
        var redirectUri, url;
        redirectUri = "" + location.href + "?status=done";
        url = 'https://getpocket.com/auth/authorize?' + ("request_token=" + requestToken + "&") + ("redirect_uri=" + redirectUri);
        return location.href = url;
      };

      Auth.prototype.getAccessToken = function() {
        var url,
          _this = this;
        url = 'https://getpocket.com/v3/oauth/authorize';
        return $.ajax({
          type: 'POST',
          url: url,
          headers: {
            'X-Accept': 'application/json'
          },
          data: {
            consumer_key: _consumerKey,
            code: localStorage.requestToken
          },
          dataType: 'json'
        }).done(function(data) {
          localStorage.accessToken = data.access_token;
          return localStorage.username = data.username;
        });
      };

      return Auth;

    })();
    if ($('body.options').length) {
      template = $('#hoge-template').text();
      $('body').append(_.template(template)());
      return new Auth($('.js-auth-button'));
    }
  });

}).call(this);
