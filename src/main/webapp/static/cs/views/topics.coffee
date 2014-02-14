window.views = {} unless window.views?
window.views.Topics = Backbone.View.extend
  el: $("#topics")
  message: $("#topics .message")
  paginator: $("#topics-paginator")
  template: _.template $('#topic-tmpl').html()

  initialize: ->
    @model.bind "reset", @render, @

  show: (page, message) ->
    @page = if page? then parseInt(page, 10) else 1
    @showMessage message
    @load()
    @$el.show()

  hide: -> @$el.hide()

  load: ->
    @model.fetch
      data:
        offset: (@page - 1)
        limit: window.config.PAGE_ROWS
      reset: yes

  showMessage: (msg) -> if msg? then @message.text(msg) else @message.text("")

  events:
    "click .delete": "delete"

  delete: (e) ->
    id = $(e.target).siblings().val()
    @model.get(id).destroy
      dataType: "text"
      success: => @load()
      error: => @showMessage "При удалении тему произошла ошибка"

  render: ->
    list = @$el.find("#topics-list")
    list.empty()
    @model.each (topic) => list.append(@template(topic.attributes))
    @renderPagination()

  renderPagination: ->
    total = Math.ceil(@model.total / window.config.PAGE_ROWS)
    if total > 1
      pagination = new window.views.Pagination()
      pagination.page = @page
      pagination.baseUrl = "topics"
      pagination.total = total
      @paginator.html(pagination.render().el)
    else
      @paginator.empty()