# == Schema Information
#
# Table name: outcomes
#
#  id         :integer          not null, primary key
#  content    :text
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_outcomes_on_topic_id  (topic_id)
#

class Outcome < ActiveRecord::Base
  include Shared::Activity

  belongs_to :topic

  def paper_trail_title
    content
  end

  def completed_for?(user)
    enrollment = topic.referred_course.enrollments.where(user: user).first
    learning_step = LearningStep.find_or_create_by(topic: topic, enrollment: enrollment)
    LearningStepRating.exists?(learning_step: learning_step, outcome: self)
  end

  def mark_completed_for(user)
    enrollment = topic.referred_course.enrollments.where(user: user).first
    learning_step = LearningStep.find_or_create_by(topic: topic, enrollment: enrollment)
    LearningStepRating.find_or_create_by(learning_step: learning_step, outcome: self)
  end

  def mark_uncompleted_for(user)
    enrollment = topic.referred_course.enrollments.where(user: user).first
    learning_step = LearningStep.find_or_create_by(topic: topic, enrollment: enrollment)
    LearningStepRating.where(learning_step: learning_step, outcome: self).destroy_all
  end
end
