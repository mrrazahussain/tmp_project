include BooksHelper

ActiveAdmin.register Category do
  permit_params :title, :position, :parent_id, :image, :description

  index do
    selectable_column
    id_column
    column :image do |c|
      image_tag c.image.url(:thumb)
    end
    column :title
    column :parent
    column :description
    actions
  end

  filter :title

  form do |f|
    f.inputs "Category Details" do
      f.input :title
      f.input :parent, collection: options_for_categories_dropdown
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end
end