# == Schema Information
#
# Table name: course_topics
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  topic_id   :integer
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_course_topics_on_course_id  (course_id)
#  index_course_topics_on_topic_id   (topic_id)
#

require 'test_helper'

class CourseTopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
