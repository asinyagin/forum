window.views = {} unless window.views?
window.views.Pagination = Backbone.View.extend
  tagname: "ul"
  className: "pagination"
  template: _.template $("#page-tmpl").html()

  render: ->
    for i in [1..@total]
      @$el.append @template(num: i, baseUrl: @baseUrl, active: @page == i)
    @