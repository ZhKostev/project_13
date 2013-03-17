class Rubric < ActiveRecord::Base
  validates :title, :language, :presence => true
end

