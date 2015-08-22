module SimpleForm
  module Components
    module Icon
      def icon(wrapper_options = nil)
        @icon ||= begin
          template.content_tag(:i, '', class: "#{options[:icon]} icon").html_safe if options[:icon].present?
        end
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icon)