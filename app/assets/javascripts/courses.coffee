# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

NextLMS.on_pages '.courses_show', ->
  $(document).on 'click', '#update-toc', ->
    topics = []
    for topic in $('#course-toc.tree.builder').jstree(true).get_json('#', {flat: true})
      topics.push
        id: topic.id
        title: topic.text
        parent: topic.parent

    $.ajax
      url: $(this).data('course-url'),
      type: 'POST',
      data: {topics: topics},
      dataType: 'script'


NextLMS.on_pages '.topics_show', ->
  $('input.outcome').on 'change', ->
    $.ajax
      url: $(this).data('url')
      dataType: "script"
      data: {status: $(this).is(':checked')}