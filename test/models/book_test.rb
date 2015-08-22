# == Schema Information
#
# Table name: books
#
#  id                 :integer          not null, primary key
#  title              :string
#  author             :string
#  edition            :string
#  summary            :text
#  file_file_name     :string
#  file_content_type  :string
#  file_file_size     :integer
#  file_updated_at    :datetime
#  cover_file_name    :string
#  cover_content_type :string
#  cover_file_size    :integer
#  cover_updated_at   :datetime
#  category_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  search_index_id    :string
#

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
