# == Schema Information
#
# Table name: learning_steps
#
#  id            :integer          not null, primary key
#  enrollment_id :integer
#  topic_id      :integer
#  completed     :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_learning_steps_on_enrollment_id  (enrollment_id)
#  index_learning_steps_on_topic_id       (topic_id)
#

class LearningStep < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :topic
  has_many :ratings, class_name: 'LearningStepRating'
end
