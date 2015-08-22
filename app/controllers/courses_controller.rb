class CoursesController < ApplicationController
  include CoursesHelper
  before_action :set_course, only: [:show, :update, :view, :edit, :update_toc]
  before_action :get_categories, only: [:show]

  def index
    @selected_categories = params[:categories].try(:split, ',') || []
    @courses = @selected_categories.blank? ? Course.all : Course.where(category_id: @selected_categories)
    @page_title = 'Courses'
  end

  def show
    @category = @course.category
  end

  def edit
    raise CanCan::SecurityError unless can? :edit, @course
    @course.topics.create(title: 'New Topic') if @course.topics.blank?
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_toc
    topics = params[:topics]
    existing_topics = @course.toc_ids
    @course.course_topics.destroy_all
    topic_ids = {}
    topics.each do |key, topic|
      topic = topic.to_hash.deep_symbolize_keys!
      if topic[:id] =~ /^j/
        t = Topic.create(title: topic[:title])
      else
        t = Topic.find(topic[:id])
        t.update_attribute :title, topic[:title]
      end
      topic_ids[topic[:id]] = t.id
      if topic[:parent] == '#'
        @course.topics << t
      else
        Topic.find(topic_ids[topic[:parent]]).children << t
      end
    end
    Topic.where(id: (existing_topics - topic_ids.values)).destroy_all
  end

  def view
    redirect_to course_topic_path(@course, @course.topics.try(:first))
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  def get_categories
    @categories = Category.hash_tree
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:title, :summary, :image, :category_id, tag_list: [])
  end
end
