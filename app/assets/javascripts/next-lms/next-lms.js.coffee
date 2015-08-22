$.fn.bindFirst = (name, fn) ->
# bind as you normally would
# don't want to miss out on any jQuery magic
  @on name, fn
  # Thanks to a comment by @Martin, adding support for
  # namespaced events too.
  @each ->
    handlers = $._data(this, 'events')[name.split('.')[0]]
    # take out the handler we just inserted from the end
    handler = handlers.pop()
    # move it at the beginning
    handlers.splice 0, 0, handler
    return
  return

class NextLMS
  @on_pages: (pages, func)->
    if pages == 'all'
      $(document).on "page:change", func
    else
      $(document).on "page:change", ->
        if $('body').is pages
          console.log "Executing events for pages #{pages}"
          func()

  @once: (func)->
    $(document).ready(func)

  @redirect: (path)->
    window.location.href = path

  @reload: ->
    window.location.href = window.location.href

(global ? window).NextLMS = NextLMS