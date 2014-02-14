window.models = {} unless window.models?
window.models.Post = Backbone.Model.extend
  validate: (attrs, options) ->
    if attrs.text.length == 0 then "Текст не должен быть пустым"