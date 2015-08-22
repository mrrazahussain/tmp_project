# == Schema Information
#
# Table name: learning_step_ratings
#
#  id               :integer          not null, primary key
#  learning_step_id :integer
#  outcome_id       :integer
#  user_rating      :integer
#  user_comment     :string
#  author_rating    :integer
#  author_comment   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class LearningStepRatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
