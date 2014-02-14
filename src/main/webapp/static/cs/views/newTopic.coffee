window.views = {} unless window.views?
window.views.NewTopic = Backbone.View.extend
  el: $("#new-topic")
  nameField: $("#new-topic [name='name']")
  textField: $("#new-topic [name='text']")
  message: $("#new-topic .message")

  checkAuth: ->
    unless window.user? then window.location.href="/"

  show: ->
    @checkAuth()
    @cleanup()
    @$el.show()

  hide: -> @$el.hide()

  cleanup: ->
    @nameField.val ""
    @textField.val ""
    @message.text ""
    @topic = new window.models.Topic()
    @post = new window.models.Post()

  events:
    "keyup [name='name']": "keyupName"
    "keyup [name='text']": "keyupText"
    "click #new-topic-cancel": "cancel"
    "click #new-topic-create": "create"

  keyup: (model, property, field) ->
    model.set(property, field.val(), validate: true)
    @fieldValid(field, model.validationError)

  keyupName: -> @keyup(@topic, "name", @nameField)

  keyupText: -> @keyup(@post, "text", @textField)

  cancel: -> window.router.navigate "topics/p1", true

  create: ->
    @topic.set 'posts', new window.models.Posts([ @post ])
    window.topics.create(
      @topic,
      success: (model, response, options) ->
        window.router.navigate "topics/#{response.id}/p1", true
      error: => @message.text "При сохранении темы произошла ошибка"
    )

  fieldValid: (field, invalid) ->
    if invalid
      field.parent().addClass "has-error"
    else
      field.parent().removeClass "has-error"