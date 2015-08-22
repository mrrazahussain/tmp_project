class Faq < Topic

  belongs_to :course

  validates :course_id, :presence => true

end
