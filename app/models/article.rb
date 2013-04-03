class Article < ActiveRecord::Base
  #TODO uncomment after friendly id will support rails 4
  #extend FriendlyId
  #friendly_id :title, use: :slugged

  has_and_belongs_to_many :rubrics
  belongs_to :origin, :class_name => Article # On front list of clones

  validates :title, :body, :language, :presence => true
  validates :language, :inclusion => {:in => SUPPORTED_LANGUAGES.map(&:to_s)}

  #return front version of article
  def front_clone
    Article.where(:origin_id => self.id).first
  end
end
