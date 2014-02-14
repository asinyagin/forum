window.models = {} unless window.models?
window.models.Posts = Backbone.Collection.extend
  model: window.models.Post
  parse: (response, options) ->
    @total = options.xhr.getResponseHeader 'X-Total-Count'
    window.models.Posts.__super__.parse.call this, response, options