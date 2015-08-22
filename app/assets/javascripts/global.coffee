NextLMS.on_pages 'all', ->
  $('.filter-container').each ->
    $list = $(this).find('.filter-list')
    $filters = $(this).find('.filter-group')
    $filters.find('a').click ->
      $filters.find('a').removeClass 'active'
      $(this).addClass 'active'
      $list.isotope filter: $(this).data('filter')
