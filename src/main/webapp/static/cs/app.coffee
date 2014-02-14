window.topics = new window.models.Topics()

manager =
  views:
    topics: new window.views.Topics({ model: window.topics })
    newTopic: new window.views.NewTopic()
    topic: new window.views.Topic()

  show: (page, args...) ->
    view.hide() for name, view of @views when name isnt page
    @views[page].show.apply(@views[page], args)

Router = Backbone.Router.extend
  routes:
    "topics/p:page": "topics"
    "topics/new-topic": "newTopic"
    "topics/:id/p:page": "topic"
    "*path": "default"

  topics: (page) -> manager.show "topics", page
  newTopic: -> manager.show "newTopic"
  topic: (id, page) -> manager.show "topic", id, page
  default: -> window.router.navigate "topics/p1", true

window.router = new Router()
Backbone.history.start()