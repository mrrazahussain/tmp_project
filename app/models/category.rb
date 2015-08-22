# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  title              :string
#  parent_id          :integer
#  position           :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  description        :text
#
# Indexes
#
#  index_categories_on_parent_id  (parent_id)
#

class Category < ActiveRecord::Base
  include Shared::Activity

  has_closure_tree order: :position
  has_attached_file :image, url: "/uploads/public/:class/:id/:attachment_:style.:extension", :styles => {:medium => "300x300>", :thumb => "64x64>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :title
  default_scope -> {}

  has_many :courses
  has_many :books

  scope :courses_categories, -> { where(id: Course.pluck(:category_id)) }
  scope :books_categories, -> { where(id: Book.pluck(:category_id)) }

  def title_for_url
    title.gsub(/[^0-9A-Za-z]/, '-')
  end

  def self.tree_data(count_for=:courses, items=Category.roots, selected_ids=[])
    arr = []
    items.each do |cat|
      item = {id: cat.id, text: "#{cat.title} (#{cat.send(count_for).count})", state: {}}
      item[:state][:selected] = true if selected_ids.include? cat.id.to_s
      item[:children] = Category.tree_data(count_for, cat.children, selected_ids) unless cat.children.blank?
      arr << item
    end
    arr
  end

  def paper_trail_title
    title
  end
end
