# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  parent_id  :integer
#  sort_order :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#  type       :string
#
# Indexes
#
#  index_topics_on_course_id  (course_id)
#

require 'test_helper'

class FaqTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
