class Product < ActiveRecord::Base
  validates_presence_of :title, :description, :image_url, :message => 'can not be blank.'
  validates_numericality_of :price, :greater_than_or_equal_to => 0.01, :message => 'must be a number.'
  validates_uniqueness_of :title, :message => 'must be unique.'
  validates :image_url, :format => {
    :with     => %r{\.(gif|jpg|png)$}i,
    :message  =>  'must be a URL for GIF, JPG or PNG image.'
  }
  validates_length_of :title, :minimum => 10, :message => 'must be at least 10 characters.'
end
