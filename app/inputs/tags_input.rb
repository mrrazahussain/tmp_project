class TagsInput < SimpleForm::Inputs::CollectionSelectInput
  def input(wrapper_options = nil)
    input_html_classes.push 'ui search dropdown tags'
    input_html_options[:multiple]='multiple'
    super
  end
end