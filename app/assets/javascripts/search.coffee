# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

NextLMS.on_pages '.search_index', ->
  $input = $('.search-heading input')
  $field = $(this).parents('.input').first()
  $result = $('.search-content .container')
  search_url = $input.data 'search-url'
  search_key = $input.data 'search-key'

  $input.on 'change', ->
    $field.addClass 'loading'
    search_value = $(this).val()

    $.ajax
      url: "#{search_url}/search/documents"
      type: 'GET'
      headers:
        'X-Api-Key': search_key
        'Access-Control-Allow-Origin': 'http://localhost:3000'
      data:
        q: search_value
        highlight: 'only_highlight'
        page: 1
        per_page: 500
      success: (data)->
        $field.removeClass 'loading'
        console.log data
        $result.html(JST['templates/search/results']({books: data}))
