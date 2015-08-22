module UiHelper
  def page_title
    if instance_variable_defined? :@page_title
      return if @page_title == false
      if @page_title.is_a? Hash
        render @page_title
      else
        @page_title
      end
    elsif content_for? :page_title
      yield :page_title
    else
      "#{params[:controller]}_#{params[:action]}"
    end
  end

  def options_for_categories_dropdown categories = Category.hash_tree, options=[]
    return @cached_options if @cached_options.present?
    options ||= []
    categories.each do |category, children|
      options << ['- ' * category.depth + category.title, category.id]
      options_for_categories_dropdown(children, options) if children.present?
    end
    options
  end

  def active_link_to(name = nil, options = nil, html_options = {}, &block)
    active_class = current_page?(options) ? ' active ' : ''

    if html_options[:wrapper]
      content_tag html_options[:wrapper], class: active_class do
        link_to name, options, html_options, &block
      end
    else
      html_options[:class] ||= ''
      html_options[:class] << active_class
      link_to name, options, html_options, &block
    end
  end
end