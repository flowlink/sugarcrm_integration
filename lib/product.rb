class Product

  def initialize(flowlink_product = {})
    @flowlink_product = flowlink_product
  end
  
  def id
    @flowlink_product['sku']
  end
  
  def sugar_product_template
    product = Hash.new
    product['id'] = @flowlink_product['sku']
    product['name'] = @flowlink_product['name']
    product['description'] = @flowlink_product['description']
    product['cost_price'] = @flowlink_product['cost_price']
    product['list_price'] = @flowlink_product['price']
    return product
  end

end