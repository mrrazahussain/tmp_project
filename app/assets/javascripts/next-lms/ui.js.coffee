class NextLMS.UI
  @modals: []

  @bootstrap: ->
    $(document).on 'click', "a[href='#']", (event)->
      event.stopPropagation()
    $(document).on 'click', '.ui.button[data-behavior="submit-form"]', (event)->
      $($(this).data('form')).submit()

    $(document).on 'click', '.message .close', (event)->
      $(this).closest('.message').transition('fade')

    Turbolinks.enableProgressBar()
    $.fn.editable.defaults.mode = 'inline'
    $.fn.editable.defaults.send = 'always'
    $.fn.editable.defaults.ajaxOptions = {type: 'put', dataType: 'json'}
    $.fn.editable.defaults.showbuttons = false
    $.fn.editable.defaults.onblur = 'submit'
    $.fn.editable.defaults.inputclass = 'form-control'
    $.fn.editable.defaults.emptytext = '_______________'
    $.fn.editabletypes.wysihtml5.defaults.tpl = '<textarea style="width: 100%;"></textarea>'
    $.fn.editabletypes.textarea.defaults.tpl = '<textarea style="width: 600px;"></textarea>'
    $('.ui.sticky').each ->
      $(this).sticky(context: $(this).data('sticky-context'))
    $('.special.cards .image').dimmer({on: 'hover'})
    $(document).on 'cocoon:after-insert', (e, insertedItem)->
      NextLMS.UI.initJSElements(insertedItem)

  @initJSElements: (scope = 'body')->
    console.log 'Initializing JS Elements'
    $('.editable', $(scope)).editable()
    $('select:not(.ui.tags)', scope).dropdown()
    $('.ui.dropdown:not(.tags)', scope).dropdown()
    $('.ui.tags', scope).dropdown({allowAdditions: true})
    $('.ui.checkbox', scope).checkbox()
    $('.ui.accordion', scope).accordion()
    $('.ui.tabular.menu .item, .ui.menu[data-behavior="tabs"] .item', scope).tab()

    $('.field.wysi', scope).each ->
      new wysihtml5.Editor $(this).find('textarea')[0],
        toolbar: $(this).find('.wysi-toolbar')[0]
        parserRules: wysihtml5ParserRules

    $('.tree', scope).each ->
      new NextLMS.UI.TOCTree(this)

    $('textarea.markdown', scope).each ->
      CodeMirror.fromTextArea this,
        mode: 'gfm'
        theme: 'default'
        lineNumbers: true
        lineWrapping: true
        
# title as one argument
# title, body as two arguments
  @showModal: ()->
    if arguments.length == 1
      modal = $(arguments[0]).appendTo('body')
    else if arguments.length == 2
      modal = $(JST['templates/ui/modal'](
        title: arguments[0]
        body: arguments[1])).appendTo('body')
    else
      modal = $(JST['templates/ui/modal'](
        title: arguments[0],
        body: arguments[1],
        footer: arguments[2])).appendTo('body')

    modal.modal
      closable: false
      transition: 'horizontal flip'
      onVisible: ->
        NextLMS.UI.initJSElements(modal)
      onHidden: ->
        $(modal).remove()

    modal.modal 'show'
    @modals.push modal

  @closeAllModals: ->
    modal.modal('hide') for modal in @modals


NextLMS.on_pages 'all', ->
  NextLMS.UI.initJSElements('body')

NextLMS.once NextLMS.UI.bootstrap