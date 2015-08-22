# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  url        :string
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_links_on_topic_id  (topic_id)
#

class Link < ActiveRecord::Base
  include Shared::Activity

  belongs_to :topic

  def paper_trail_title
    url
  end

end
