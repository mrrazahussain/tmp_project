class NextLMS.UI.TOCTree
  constructor: (@element)->
#$(@element).on 'keydown', 'input.jstree-rename-input', @change_parent
    $(@element).jstree
      core:
        animation: 1,
        check_callback: true
        data: $(@element).data('tree-data')
        themes:
          name: 'proton'
          responsive: true
          icons: false
      plugins: ['dnd']

    @tree = $(@element).jstree(true)
    $(@element).on 'loaded.jstree', =>
      @tree.open_all()

    # If the tree is editable
    if $(@element).hasClass 'builder'
      @attach_events()
    else
      @attach_navigation()

  attach_events: =>
    $(@element).on 'focus', 'input.jstree-rename-input', (event)=>
      $(event.target).bindFirst 'keydown', @change_parent
    $(@element).on 'activate_node.jstree', @edit_node
    $(@element).on 'rename_node.jstree', @editing_finished

  attach_navigation: =>
    $(@element).on 'activate_node.jstree', (event, data)=>
      NextLMS.redirect(data.node.original.url)

  edit_node: (event, data)=>
    @active_node = data.node
    @tree.edit data.node, null

  editing_finished: (event, data)=>
    #@active_node = null
    console.log 'editing finished', data
    @tree.delete_node(data.node) if data.text == ''

  change_parent: (event)=>
    keyCode = event.keyCode || event.which
    shiftKey = !!event.shiftKey

    # If only tab key pressed
    if keyCode == 9 and !shiftKey
      event.preventDefault()
      node = @active_node
      $(event.currentTarget).val(' ') if $(event.currentTarget).val() == ''
      $(event.currentTarget).trigger 'blur'
      node = @tree.get_node(node)
      node_index = @tree.get_node(node.parent).children.indexOf(node.id)
      node2 = @tree.get_node(node.parent).children[node_index - 1]
      @tree.move_node node, node2, 'last'
      @tree.open_node node2
      @tree.edit node

    # If Shift + Tab is pressed
    else if keyCode == 9 and shiftKey
      event.preventDefault()
      node = @active_node
      $(event.currentTarget).val(' ') if $(event.currentTarget).val() == ''
      $(event.currentTarget).trigger 'blur'
      node = @tree.get_node(node)
      parent_node = @tree.get_node(node.parent)
      desired_parent = @tree.get_node(parent_node.parent)
      parent_node_index = desired_parent.children.indexOf(parent_node.id)
      console.log desired_parent
      @tree.move_node node, desired_parent, parent_node_index + 1
      @tree.open_node desired_parent
      @tree.edit node

    else if keyCode == 13
      node = @active_node
      $(event.currentTarget).trigger 'blur'
      console.log @active_node, node.parent, @tree.get_node(node.parent).children, node.id
      node = @tree.get_node(node)
      parent = node.parent
      new_node = {"text": ''}
      position = @tree.get_node(node.parent).children.indexOf(node.id) + 1
      sel = @tree.create_node(parent, new_node, position)
      @active_node = sel
      @tree.edit sel

    else if (keyCode == 8 or keyCode == 46) and $(event.target).val() == ''
      event.preventDefault()
      @tree.delete_node(@tree.get_node(@active_node))
