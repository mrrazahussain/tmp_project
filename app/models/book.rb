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

class Book < ActiveRecord::Base
  include Shared::Activity

  has_attached_file :file, url: "/uploads/protected/:class/:category_id_and_name/:id/:basename.:extension"
  validates_attachment_content_type :file, :content_type => ['application/pdf', /\Apdf\/.*\Z/]

  has_attached_file :cover, url: "/uploads/public/:class/:category_id_and_name/:id/:attachment_:style.:extension", :styles => {:medium => "300x400>", :thumb => "150x200>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true

  after_create :create_index
  after_destroy :drop_index

  belongs_to :category

  def self.categories_for(books = Book.all)
    Category.
        joins(:books).
        group('categories.id').
        where('books.id IN (?)', books.collect(&:id)).
        select('categories.id, categories.title, COUNT(books.id) as count').
        having('COUNT(books.id) > 0')
  end

  def index_data
    {
        content_id: self.id,
        content_type: self.class.to_s,
        meta: {
            category_name: self.category.title,
            category_id: self.category_id,
            book_title: self.title
        },
        file: File.new((self.file.queued_for_write.keys.blank? ? self.file.path : self.file.queued_for_write[:original].path), 'rb')
    }
  end

  private
  def create_index
    result = RestClient.post(
        "#{SETTINGS.search_server.url}/import/file/documents.json",
        self.index_data,
        {'X-Api-Key' => SETTINGS.search_server.api_key}
    )
    result = JSON.parse(result)
    self.search_index_id = result['_id']
    self.save
  end

  def drop_index
    if self.search_index_id
      RestClient.delete(
          "#{SETTINGS.search_server.url}/drop/documents/#{self.search_index_id}",
          {'X-Api-Key' => SETTINGS.search_server.api_key}
      )
    end
  end
end
