window.models = {} unless window.models?
window.models.Topics = Backbone.Collection.extend
  model: window.models.Topic
  url: 'topics'

  parse: (response, options) ->
    @total = options.xhr.getResponseHeader 'X-Total-Count'
    window.models.Topics.__super__.parse.call this, response, options