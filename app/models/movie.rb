class Movie < ApplicationRecord
  has_many :show_times, :dependent => :destroy
  has_many :comments
  has_many :theatres, :through => :show_times
  
  validates :name, :rated, :genre, :year, :director, :presence => true
end
