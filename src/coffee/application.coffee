$ ->
  class Auth
    _consumerKey = '17342-886441b1370ebdcaa519f57f'

    constructor: (@$el) ->
      @events()

      if '?status=done' == location.search
        @getAccessToken()

    events: ->
      @$el.on 'click', @getRequestToken.bind(@)

    getRequestToken: ->
      redirectUri = location.href
      url = 'https://getpocket.com/v3/oauth/request'

      $.ajax(
        type: 'POST'
        url: url
        data:
          consumer_key: _consumerKey
          redirect_uri: redirectUri
      ).done (data) =>
        requestToken = data.split('=')[1]
        localStorage.requestToken = requestToken

        @redirect(requestToken)

    redirect: (requestToken) ->
      redirectUri = "#{location.href}?status=done"
      url = 'https://getpocket.com/auth/authorize?' +
            "request_token=#{requestToken}&" +
            "redirect_uri=#{redirectUri}"

      location.href = url

    getAccessToken: ->
      url = 'https://getpocket.com/v3/oauth/authorize'

      $.ajax(
        type: 'POST'
        url: url
        headers:
          'X-Accept': 'application/json'
        data:
          consumer_key: _consumerKey
          code: localStorage.requestToken
        dataType: 'json'
      ).done (data) =>
        localStorage.accessToken = data.access_token
        localStorage.username = data.username


  if $('body.options').length
    template = $('#hoge-template').text()
    $('body').append(_.template(template)())

    new Auth($('.js-auth-button'))
