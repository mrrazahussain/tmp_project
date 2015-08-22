# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

NextLMS.on_pages '.topics_show', ->
  $(document).on 'click', 'a[data-modal="book-search"]', ->
    $link = $(this)
    NextLMS.BooksDialog.show {}, (reference)->
      $link.parents('.input-group').find('input.form-control').val(reference)
