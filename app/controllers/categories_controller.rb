class CategoriesController < ApplicationController
  def show
    @category = Category.find params[:id]
    @sub_categories = @category.children
    @courses = @category.courses
  end

  def tree_data
    categories = Category.all.collect { |c|
      {
        :id => c.id,
        :text => c.title,
        :parent => c.parent ? c.parent.id : '#',
        :state => {
          :opened => true
        }
      }
    }
    render json: categories.to_json
  end

end
