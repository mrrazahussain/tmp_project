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
#

class Topic < ActiveRecord::Base
  include Shared::Activity
  has_closure_tree order: 'sort_order', with_advisory_lock: false

  # Course relations only valid root topics
  has_one :course_topic
  has_one :course, through: :course_topic
  has_many :links, dependent: :delete_all
  has_many :outcomes, dependent: :delete_all
  accepts_nested_attributes_for :links, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :outcomes, :reject_if => :all_blank, :allow_destroy => true

  validates :title, :presence => true

  def next
    Topic.find_by_id(referred_course.toc_ids[referred_course.toc_ids.index(self.id) + 1])
  end

  def previous
    Topic.find_by_id(referred_course.toc_ids[referred_course.toc_ids.index(self.id) - 1])
  end

  def as_toc_json
    {id: id, text: title, url: Rails.application.routes.url_helpers.course_topic_path(self.referred_course, self), children: self.children.map(&:as_toc_json)}
  end

  def toc_ids
    [id, self.children.map(&:toc_ids)]
  end

  def referred_course
    root.course
  end

  def paper_trail_title
    title
  end
end

