require 'date'

class Order

  def initialize(flowlink_order = {})
    @flowlink_order = flowlink_order
  end

  def flowlink_id
    @flowlink_order['id']
  end

  def description
    @flowlink_order.to_s
    desc = "Number: #{flowlink_id}\n"
    desc += "Status: #{@flowlink_order['status']}\n" if @flowlink_order.has_key? 'status'
    desc += "Items: \n"
    @flowlink_order['line_items'].each do |item|
      desc += "- #{item['product_id']}, #{item['name']}, #{item['quantity']} unit(s)\n"
    end
    if @flowlink_order.has_key? 'totals'
      ['item', 'adjustment', 'tax', 'shipping', 'payment', 'order'].each do |adjustment|
        desc += "#{adjustment.capitalize} Total: #{@flowlink_order['totals'][adjustment]}\n"
      end
    end

    desc
  end

  def email
    @flowlink_order['email']
  end

  def sugar_opportunity
    opportunity = Hash.new
    opportunity['id'] = flowlink_id
    opportunity['sales_stage'] = 'Closed Won'
    opportunity['name'] = "FlowLink ID #{@flowlink_order['id']}"
    opportunity['description'] = description
    opportunity['lead_source'] = 'Web Site'
    opportunity['date_closed'] = DateTime.parse(@flowlink_order['placed_on']).to_date.to_s if @flowlink_order.has_key? 'placed_on'
    opportunity['amount'] = @flowlink_order['totals']['order'] if @flowlink_order.has_key? 'totals'
    return opportunity
  end

  def sugar_revenue_line_items
    rlis = Array.new

    ## Add one RLI for each line item
    @flowlink_order['line_items'].each do |line_item|
      rli = Hash.new
      rli['sku'] = line_item['product_id']
      rli['product_template_id'] = line_item['product_id']
      rli['name'] = line_item['name']
      rli['quantity'] = line_item['quantity']
      rli['cost_price'] = line_item['price']
      rli['list_price'] = line_item['price']
      rli['likely_case'] = line_item['quantity'] * line_item['price']
      rli['sales_stage'] = 'Closed Won'
      rli['probability'] = 100
      rli['date_closed'] = DateTime.parse(@flowlink_order['placed_on']).to_date.to_s if @flowlink_order.has_key? 'placed_on'
      rlis.append(rli)
    end

    ## And one RLI for each adjustment, tax, shipping
    if @flowlink_order.has_key? 'totals'
      ['adjustment', 'tax', 'shipping'].each do |adjustment|
        rli = Hash.new
        rli['name'] = adjustment
        rli['quantity'] = 1
        rli['cost_price'] = @flowlink_order['totals'][adjustment]
        rli['list_price'] = @flowlink_order['totals'][adjustment]
        rli['likely_case'] = @flowlink_order['totals'][adjustment]
        rli['sales_stage'] = 'Closed Won'
        rli['probability'] = 100
        rli['date_closed'] = DateTime.parse(@flowlink_order['placed_on']).to_date.to_s
        rlis.append(rli)
      end
    end

    return rlis
  end

end
