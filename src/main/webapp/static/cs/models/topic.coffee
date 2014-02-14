window.models = {} unless window.models?
window.models.Topic = Backbone.Model.extend
  initialize: ->
    @bind(
      "change:id change:posts",
      => @get("posts").url = "topics/#{@id}/posts"
    )
    @set 'posts', new window.models.Posts()

  validate: (attrs, options) ->
    unless (0 < attrs.name.length < 32)
      'Тема должна содержать от 0 до 32 символов'