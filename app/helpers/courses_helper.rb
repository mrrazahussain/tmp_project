module CoursesHelper
  def xeditable? object = nil
    can? :edit, object
  end

  def editable_topic topic, parent_topic
    if xeditable?(topic)
      link_to '', '#', 'data-value' => topic.title, 'data-parent_id' => parent_topic.try(:id), 'data-pk' => (topic.id||'new'), :class => 'topic', 'data-type' => 'text'
    else
      topic.title
    end
  end
end
