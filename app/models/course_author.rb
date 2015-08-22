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

class CourseAuthor < ActiveRecord::Base
  include Shared::Activity

  belongs_to :user
  belongs_to :course

  def paper_trail_title
    "#{course.paper_trail_title} - #{user.paper_trail_title}"
  end
end
