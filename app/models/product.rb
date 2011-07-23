class Product < ActiveRecord::Base
  default_scope :order => 'title'
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  validates_presence_of :title, :description, :locale, :image_url, :message => 'can not be blank.'
  validates_numericality_of :price, :greater_than_or_equal_to => 0.01, :message => 'must be a number.'
  validates_numericality_of :price, :less_than_or_equal_to => 500, :message => 'is too high.'
  validates_uniqueness_of :title, :message => 'must be unique.'
  validates_uniqueness_of :image_url, :message => 'must be unique.'
  validates :image_url, :format => {
    :with     => %r{\.(gif|jpg|png)$}i,
    :message  =>  'must be a URL for GIF, JPG or PNG image.'
  }
  validates_length_of :title, :minimum => 10, :message => 'must be at least 10 characters.'
  def self.find_products_for_sale
    find(:all, :order => "title", :conditions => {:locale => I18n.locale})
  end
  
  private
    
    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
