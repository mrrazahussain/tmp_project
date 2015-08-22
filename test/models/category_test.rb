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

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
