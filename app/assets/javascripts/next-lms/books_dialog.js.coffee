class NextLMS.BooksDialog
  @show: (options={}, callback)->
    options.title ||= 'Search Book'
    $('body').append(JST['templates/books_dialog/dialog'](options: options))
    $element = $('#books-search-dialog')
    $element.find('.books-sidebar').on('changed.jstree', (e, data) ->
      # start ajax call on click
      $.ajax(
        type: 'GET'
        dataType: 'json'
        url: '/books/books_data?category=' + data.selected
      ).done (books_data) ->
        $element.find('.main-content').html('').append(JST['templates/books_dialog/list'](books_data: books_data))
      # end ajax call on click
      return
    ).jstree
      core:
        "multiple" : false,
        data:
          url: '/categories/tree_data'
          data : (node)->
            { 'id' : node.id }

    $element.find('.modal-footer button.btn-primary').click ->
      $book_id = $('[name=book_id]').val()
      $book_pages = $('input#book-pages').val()
      callback("book://#{$book_id}##{$book_pages}")
      $element.modal 'hide'

    $element.on 'hidden.bs.modal', ->
      $element.remove()

    $element.modal 'show'
