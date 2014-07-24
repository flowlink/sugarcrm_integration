require 'date'

class Order

  def initialize(wombat_order = {})
    @wombat_order = wombat_order
  end

  def wombat_id
    @wombat_order['id']
  end

  def description
    @wombat_order.to_s
    desc = "Number: #{wombat_id}\n"
    desc += "Status: #{@wombat_order['status']}\n" if @wombat_order.has_key? 'status'
    desc += "Items: \n"
    @wombat_order['line_items'].each do |item|
      desc += "- #{item['product_id']}, #{item['name']}, #{item['quantity']} unit(s)\n"
    end
    if @wombat_order.has_key? 'totals'
      ['item', 'adjustment', 'tax', 'shipping', 'payment', 'order'].each do |adjustment|
        desc += "#{adjustment.capitalize} Total: #{@wombat_order['totals'][adjustment]}\n"
      end
    end

    desc
  end

  def email
    @wombat_order['email']
  end

  def sugar_opportunity
    opportunity = Hash.new
    opportunity['id'] = wombat_id
    opportunity['sales_stage'] = 'Closed Won'
    opportunity['name'] = "Wombat ID #{@wombat_order['id']}"
    opportunity['description'] = description
    opportunity['lead_source'] = 'Web Site'
    opportunity['date_closed'] = DateTime.parse(@wombat_order['placed_on']).to_date.to_s if @wombat_order.has_key? 'placed_on'
    opportunity['amount'] = @wombat_order['totals']['order'] if @wombat_order.has_key? 'totals'
    return opportunity
  end

  def sugar_revenue_line_items
    rlis = Array.new

    ## Add one RLI for each line item
    @wombat_order['line_items'].each do |line_item|
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
      rli['date_closed'] = DateTime.parse(@wombat_order['placed_on']).to_date.to_s if @wombat_order.has_key? 'placed_on'
      rlis.append(rli)
    end

    ## And one RLI for each adjustment, tax, shipping
    if @wombat_order.has_key? 'totals'
      ['adjustment', 'tax', 'shipping'].each do |adjustment|
        rli = Hash.new
        rli['name'] = adjustment
        rli['quantity'] = 1
        rli['cost_price'] = @wombat_order['totals'][adjustment]
        rli['list_price'] = @wombat_order['totals'][adjustment]
        rli['likely_case'] = @wombat_order['totals'][adjustment]
        rli['sales_stage'] = 'Closed Won'
        rli['probability'] = 100
        rli['date_closed'] = DateTime.parse(@wombat_order['placed_on']).to_date.to_s
        rlis.append(rli)
      end
    end

    return rlis
  end

end
