class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  
  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product_id)
      current_item.price = current_item.product.price
    end
    current_item
  end
  
  def remove_product(item)
    if item.quantity > 1
      item.quantity -= 1
      item.save
      item
    else
      item.destroy
      false
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
  def total_items
    line_items.sum(:quantity)
  end
end