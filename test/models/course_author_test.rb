# == Schema Information
#
# Table name: course_authors
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CourseAuthorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
