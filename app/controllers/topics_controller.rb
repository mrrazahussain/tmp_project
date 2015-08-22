class TopicsController < ApplicationController
  load_and_authorize_resource :topic
  #load_and_authorize_resource :topic, through: :course
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :next, :previous]

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/1/edit
  def edit
    @topic.links.build
    @topic.outcomes.build
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        Topic.find(params[:topic][:parent_topic_id]).children << @topic if params[:topic][:parent_topic_id].present?
        format.js
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_outcome
    @outcome = @topic.outcomes.find(params[:outcome_id])
    if params[:status] == 'true'
      @outcome.mark_completed_for(current_user)
    else
      @outcome.mark_uncompleted_for(current_user)
    end
    render nothing: true
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    if params[:course_id].present?
      @course = Course.find(params[:course_id])
      @category = @course.category
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def topic_params
    params.require(:topic).permit(:title, :content, links_attributes: [:id, :url, :_destroy], outcomes_attributes: [:id, :content, :_destroy])
  end
end
