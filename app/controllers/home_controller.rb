class HomeController < ApplicationController
  def index
    @page_title = false
    @courses = Course.order("updated_at ASC").limit(6)
    @books = Book.order("updated_at ASC").limit(6)
    @categories = Category.order("updated_at ASC").all
  end
end
