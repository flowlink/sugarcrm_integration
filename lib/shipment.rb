class Shipment

  def initialize(wombat_shipment = {})
    @wombat_shipment = wombat_shipment
  end

  def wombat_id
    @wombat_shipment['id']
  end

  def order_id
    @wombat_shipment['order_id']
  end
  
  def email
    @wombat_shipment['email']
  end

  def sugar_note
    desc = "Number: #{wombat_id}\n"
    desc += "Status: #{@wombat_shipment['status']}\n"
    desc += "Shipping Method: #{@wombat_shipment['shipping_method']}\n"
    desc += "Tracking: #{@wombat_shipment['tracking']}\n"
    desc += "Shipped On: #{@wombat_shipment['shipped_at']}\n"
    desc += "Items: \n"
    @wombat_shipment['items'].each do |item|
      desc += "- #{item['product_id']}, #{item['name']}, #{item['quantity']} unit(s)\n"
    end

    note = Hash.new
    note['name'] = "Shipment #{wombat_id}"
    note['description'] = desc

    return note
  end
  
  def wombat_order
    order = @wombat_shipment.clone
    order['id'] = @wombat_shipment['order_id']
    order['line_items'] = order['items']
    order
  end

end
