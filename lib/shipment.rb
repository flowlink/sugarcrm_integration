class Shipment

  def initialize(flowlink_shipment = {})
    @flowlink_shipment = flowlink_shipment
  end

  def flowlink_id
    @flowlink_shipment['id']
  end

  def order_id
    @flowlink_shipment['order_id']
  end
  
  def email
    @flowlink_shipment['email']
  end

  def sugar_note
    desc = "Number: #{flowlink_id}\n"
    desc += "Status: #{@flowlink_shipment['status']}\n"
    desc += "Shipping Method: #{@flowlink_shipment['shipping_method']}\n"
    desc += "Tracking: #{@flowlink_shipment['tracking']}\n"
    desc += "Shipped On: #{@flowlink_shipment['shipped_at']}\n"
    desc += "Items: \n"
    @flowlink_shipment['items'].each do |item|
      desc += "- #{item['product_id']}, #{item['name']}, #{item['quantity']} unit(s)\n"
    end

    note = Hash.new
    note['name'] = "Shipment #{flowlink_id}"
    note['description'] = desc

    return note
  end
  
  def flowlink_order
    order = @flowlink_shipment.clone
    order['id'] = @flowlink_shipment['order_id']
    order['line_items'] = order['items']
    order
  end

end
