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

require 'test_helper'

class OutcomeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
