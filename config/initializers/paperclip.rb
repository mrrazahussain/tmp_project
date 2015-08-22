Paperclip.interpolates('category_id_and_name') do |attachment, style|
  "#{attachment.instance.category_id}_#{attachment.instance.category.title}".parameterize
end