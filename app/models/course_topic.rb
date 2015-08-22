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

class CourseTopic < ActiveRecord::Base
  belongs_to :course
  belongs_to :topic

  after_save :update_sorting

  def self.sort_children course_id
    children = self.where(course_id: course_id).order('course_topics.order ASC').order('updated_at DESC')
    children.each_with_index do |child, index|
      unless child.order == index
        child.update_column :order, index
      end
    end
  end

  def update_sorting
    CourseTopic.sort_children self.course_id
  end
end
