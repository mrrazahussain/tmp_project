# == Schema Information
#
# Table name: course_subscriptions
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CourseSubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
