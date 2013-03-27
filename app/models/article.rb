class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_and_belongs_to_many :rubrics

  validates :title, :body, :presence => true
  validates :language, :inclusion => {:in => SUPPORTED_LANGUAGES.map(&:to_s)}
end
