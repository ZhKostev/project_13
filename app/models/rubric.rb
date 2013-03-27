class Rubric < ActiveRecord::Base
  #TODO uncomment after friendly id will support rails 4
  #extend FriendlyId
  #friendly_id :title, use: :slugged

  has_and_belongs_to_many :articles

  validates :title, :language, :presence => true
  validates :language, :inclusion => {:in => SUPPORTED_LANGUAGES.map(&:to_s)}

  scope :for_language, lambda { |language| where(:language => language.to_s) }
end

