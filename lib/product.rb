class Product

  def initialize(wombat_product = {})
    @wombat_product = wombat_product
  end
  
  def id
    @wombat_product['sku']
  end
  
  def sugar_product_template
    product = Hash.new
    product['id'] = @wombat_product['sku']
    product['name'] = @wombat_product['name']
    product['description'] = @wombat_product['description']
    product['cost_price'] = @wombat_product['cost_price']
    product['list_price'] = @wombat_product['price']
    return product
  end

end