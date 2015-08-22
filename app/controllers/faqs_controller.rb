class FaqsController < ApplicationController

  before_action :set_faq, only: [:show, :update, :edit]

  def show
    @category = @faq.course.category
  end

  def edit

  end

  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.js
        format.html { redirect_to courses_faq_path(@faq.course), notice: 'FAQs was successfully updated.' }
        format.json { render :show, status: :ok, location: @faq }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_faq
    @faq = Course.find(params[:course_id]).faq
  end

  def faq_params
    params.require(:faq).permit(:title, :content, :course_id)
  end

end
