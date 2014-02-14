window.views = {} unless window.views?
window.views.Topic = Backbone.View.extend
  el: $("#topic")
  postForm: $("#new-post")
  textField: $("#new-post [name='text']")
  message: $("#new-post .message")
  paginator: $("#posts-paginator")
  template: _.template $("#post-tmpl").html()

  initialize: -> _.bindAll this, "delete"

  checkAuth: ->
    if window.user? then @postForm.show() else @postForm.hide()

  show: (topicId, page) ->
    @checkAuth()
    @cleanup()
    @page = if page? then parseInt(page, 10) else 1
    @topic = new window.models.Topic(id: topicId)
    @topic.get("posts").bind "reset", @render, @
    @load()
    @$el.show()

  hide: -> @$el.hide()

  cleanup: ->
    @textField.val ""
    @message.text ""
    @post = new window.models.Post()
    @fieldValid @textField, null

  load: ->
    @topic.get("posts").fetch
      data:
        offset: (@page - 1)
        limit: window.config.PAGE_ROWS
      reset: yes

  render: ->
    list = @$el.find("#posts-list")
    list.empty()
    @topic.get('posts').each (post) => list.append @template(post.attributes)
    @renderPagination()

  renderPagination: ->
    total = Math.ceil(@topic.get("posts").total / window.config.PAGE_ROWS)
    if total > 1
      pagination = new window.views.Pagination()
      pagination.page = @page
      pagination.baseUrl = "topics/#{@topic.id}"
      pagination.total = total
      @paginator.html(pagination.render().el)
    else
      @paginator.html ""

  events:
    "keyup [name='text']": "keyup"
    "click #new-post-create": "create"
    "click .delete": "delete"

  create: ->
    @topic.get("posts").create(
      @post
      success: =>
        @cleanup()
        @load()
      error: =>
        @message.text "При сохранении сообщения произошла ошибка"
    )

  keyup: ->
    @post.set "text", @textField.val(), validate: true
    @fieldValid @textField, @post.validationError

  delete: (e) ->
    id = $(e.target).siblings().val()
    @topic.get("posts").get(id).destroy
      dataType: "text"
      success: => @load()
      error: => @message.text "При удалении сообщения произошла ошибка"

  fieldValid: (field, invalid) ->
    if invalid
      field.parent().addClass "has-error"
    else
      field.parent().removeClass "has-error"