# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           default(""), not null
#  email                  :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  admin                  :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  include Shared::Activity
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :course_authors
  has_many :authored_courses, through: :course_authors, source: :course

  scope :specialists, -> { where(id: CourseAuthor.pluck(:user_id)) }

  def ldap_before_save
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.username, LDAP_CONFIG[:attributes][:email]).first
    self.first_name = Devise::LDAP::Adapter.get_ldap_param(self.username, LDAP_CONFIG[:attributes][:first_name]).first
    self.last_name = Devise::LDAP::Adapter.get_ldap_param(self.username, LDAP_CONFIG[:attributes][:last_name]).first
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  alias_method :title, :full_name

  def full_name_with_email
    "#{first_name} #{last_name} (#{email})"
  end

  def paper_trail_title
    full_name_with_email
  end
end
