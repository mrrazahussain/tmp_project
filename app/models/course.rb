# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  title              :string
#  summary            :text
#  category_id        :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_courses_on_category_id  (category_id)
#

class Course < ActiveRecord::Base
  include Shared::Activity

  has_attached_file :image, url: "/uploads/public/:class/:id/:attachment_:style.:extension", :styles => {:medium => "300x300>", :thumb => "64x64>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  acts_as_taggable

  validates_presence_of :title

  belongs_to :category
  has_many :course_authors
  has_many :authors, through: :course_authors, source: :user

  has_many :enrollments
  has_many :users, through: :enrollments, source: :user

  has_many :course_topics, -> { order('course_topics.order ASC') }
  has_many :topics, through: :course_topics

  def self.categories_for(courses = Course.all)
    Category.
        joins(:courses).
        group('categories.id').
        where('courses.id IN (?)', courses.collect(&:id)).
        select('categories.id, categories.title, COUNT(courses.id) as count').
        having('COUNT(courses.id) > 0')
  end

  def toc
    self.topics.map(&:as_toc_json)
  end

  def toc_ids
    [self.topics.map(&:toc_ids)].flatten
  end

  def paper_trail_title
    title
  end
end
