class BooksController < ApplicationController
  include BooksHelper

  def index
    @selected_categories = params[:categories].try(:split, ',') || []
    @books = @selected_categories.blank? ? Book.all : Book.where(category_id: @selected_categories)
    @page_title = false
  end

  def show
    if !!(params[:id] =~ /\A[-+]?[0-9]+\z/)
      @book = Book.find(params[:id])
      @page_title = @book.title
      @category = @book.category
      @book_reference = build_book_reference(@book, [])
    else
      @book, @pages = get_book_from_reference(decrypt_book_reference(params[:id]))
      @book = Book.find(@book)
      @page_title = @book.title
      @category = @book.category
      @book_reference = decrypt_book_reference(params[:id])
    end
  end

  def load
    @book_reference = decrypt_book_reference(params[:id])
    @book_id, @pages = get_book_from_reference(@book_reference)
    @book = Book.find(@book_id)

    if @pages.blank?
      send_file @book.file.path
    else
      require 'tempfile'
      file = Tempfile.open('prefix', Rails.root.join('tmp'))
      Docsplit.extract_pages(@book.file.path, output: file.path, pages: [3, 5, 10])
      File.open(file.path, 'r') do |f|
        send_data f.read
      end
      File.delete(file.path)
    end
  end

  def books_data
    category_id = params['category']
    books = Book.where('category_id =?', category_id)
    data = books.collect { |b| {id: b.id, title: b.title, cover_url: b.cover.url(:thumb)} }
    render json: data.to_json
  end
end
