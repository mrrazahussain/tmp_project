include BooksHelper

ActiveAdmin.register Faq do
  permit_params :title, :content, :course_id

  index do
    selectable_column
    id_column
    column :title
    column :content
    actions
  end

  filter :title

  form do |f|
    f.inputs "FQAs Details" do
      f.input :course, as: :select
      f.input :title
      f.input :content
    end
    f.actions
  end
end
