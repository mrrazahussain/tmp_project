include BooksHelper

ActiveAdmin.register Book do
  permit_params :title, :category_id, :summary, :edition, :cover, :file

  index do
    selectable_column
    id_column
    column :cover do |c|
      image_tag c.cover.url(:thumb)
    end
    column :title
    column :category
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Category Details" do
      f.input :title
      f.input :category, collection: options_for_categories_dropdown
      f.input :summary
      f.input :edition
      f.input :cover, as: :file
      f.input :file, as: :file
    end
    f.actions
  end

  collection_action :upload, method: :post do
    require 'rmagick'
    files = params[:books_upload][:files]
    files.each do |file|
      if file.content_type =~ /pdf/
        book = Book.new
        book.title = file.original_filename.split('.')[0...-1].join(' ').gsub('_', ' ').gsub('-', ' ')
        Magick::ImageList.new("#{file.tempfile.path}[0]").first.write("#{file.tempfile.path}.png")
        book.cover = File.open("#{file.tempfile.path}.png")
        book.category_id = params[:books_upload][:category_id]
        book.file = file
        book.save
        puts book.errors.full_messages
      end
    end
    redirect_to collection_path, notice: "Files uploaded successfully!"
  end

  sidebar "Upload Files", only: :index, priority: 0, partial: 'upload'
end