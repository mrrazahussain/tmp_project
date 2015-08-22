# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  name            :string
#  attachable_id   :integer
#  attachable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Attachment < ActiveRecord::Base

  belongs_to :attachable, :polymorphic => true
  has_attached_file :file, url: "/uploads/public/:class/:id/:attachment_:style.:extension", :styles => {:medium => "300x300>", :thumb => "64x64>"}, :default_url => "/images/:style/missing.png"
  #accepts_nested_attributes_for :attachable, :reject_if => :all_blank, :allow_destroy => true

end
