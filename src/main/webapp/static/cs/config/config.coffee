window.config = {} unless window.config?
window.config.PAGE_ROWS = 5
_.templateSettings =
  interpolate: /\<\@\=(.+?)\@\>/gim
  evaluate: /\<\@(.+?)\@\>/gim
  escape: /\<\@\-(.+?)\@\>/gim