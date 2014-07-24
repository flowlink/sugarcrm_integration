class Shipment

  def initialize(spree_shipment = {})
    @spree_shipment = spree_shipment
  end

  def wombat_id
    @spree_shipment['id']
  end

  def order_id
    @spree_shipment['order_id']
  end
  
  def email
    @spree_shipment['email']
  end

  def sugar_note
    desc = "Number: #{wombat_id}\n"
    desc += "Status: #{@spree_shipment['status']}\n"
    desc += "Shipping Method: #{@spree_shipment['shipping_method']}\n"
    desc += "Tracking: #{@spree_shipment['tracking']}\n"
    desc += "Shipped On: #{@spree_shipment['shipped_at']}\n"
    desc += "Items: \n"
    @spree_shipment['items'].each do |item|
      desc += "- #{item['product_id']}, #{item['name']}, #{item['quantity']} unit(s)\n"
    end

    note = Hash.new
    note['name'] = "Shipment #{wombat_id}"
    note['description'] = desc

    return note
  end
  
  def wombat_order
    order = @spree_shipment.clone
    order['id'] = @spree_shipment['order_id']
    order['line_items'] = order['items']
    order
  end

end
