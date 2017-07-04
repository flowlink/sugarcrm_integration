class Customer

  attr_accessor :sugar_contact_id

  def initialize(flowlink_customer = {})
    @flowlink_customer = flowlink_customer

    if @flowlink_customer['firstname'].nil? || @flowlink_customer['firstname'].empty?
      if !@flowlink_customer['billing_address'].nil?
        @flowlink_customer['firstname'] = @flowlink_customer['billing_address']['firstname']
      elsif !@flowlink_customer['shipping_address'].nil?
        @flowlink_customer['firstname'] = @flowlink_customer['shipping_address']['firstname']
      else
        @flowlink_customer['firstname'] = 'Empty'
      end
    end
    if @flowlink_customer['lastname'].nil? || @flowlink_customer['lastname'].empty?
      if !@flowlink_customer['billing_address'].nil?
        @flowlink_customer['lastname'] = @flowlink_customer['billing_address']['lastname']
      elsif !@flowlink_customer['shipping_address'].nil?
        @flowlink_customer['lastname'] = @flowlink_customer['shipping_address']['lastname']
      else
        @flowlink_customer['lastname'] = 'Empty'
      end
    end
  end

  def flowlink_id
    @flowlink_customer['id']
  end

  def email
    @flowlink_customer['email']
  end

  def sugar_account
    account = Hash.new
    account['name']        = "#{@flowlink_customer['firstname']} #{@flowlink_customer['lastname']}"
    account['description'] = "#{@flowlink_customer['firstname']} #{@flowlink_customer['lastname']}"
    account['email']       = [{
      'email_address' => @flowlink_customer['email'],
      'primary_address' => true
    }]
    if !@flowlink_customer['shipping_address'].nil?
      account['shipping_address_street']     = @flowlink_customer['shipping_address']['address1']
      account['shipping_address_street_2']   = @flowlink_customer['shipping_address']['address2']
      account['shipping_address_city']       = @flowlink_customer['shipping_address']['city']
      account['shipping_address_state']      = @flowlink_customer['shipping_address']['state']
      account['shipping_address_postalcode'] = @flowlink_customer['shipping_address']['zipcode']
      account['shipping_address_country']    = @flowlink_customer['shipping_address']['country']
      account['phone_alternate']             = @flowlink_customer['shipping_address']['phone']
    end
    if !@flowlink_customer['billing_address'].nil?
      account['billing_address_street']      = @flowlink_customer['billing_address']['address1']
      account['billing_address_street_2']    = @flowlink_customer['billing_address']['address2']
      account['billing_address_city']        = @flowlink_customer['billing_address']['city']
      account['billing_address_state']       = @flowlink_customer['billing_address']['state']
      account['billing_address_postalcode']  = @flowlink_customer['billing_address']['zipcode']
      account['billing_address_country']     = @flowlink_customer['billing_address']['country']
      account['phone_office']                = @flowlink_customer['billing_address']['phone']
    end
    account['lead_source']                 = 'Web Site'
    return account
  end

  def sugar_contact
    contact = Hash.new
    contact['first_name']  = @flowlink_customer['firstname']
    contact['last_name']   = @flowlink_customer['lastname']
    contact['description'] = "#{@flowlink_customer['firstname']} #{@flowlink_customer['lastname']}"
    contact['email']       = [{
      'email_address' => @flowlink_customer['email'],
      'primary_address' => true
    }]
    if !@flowlink_customer['shipping_address'].nil?
      contact['primary_address_street']     = @flowlink_customer['shipping_address']['address1']
      contact['primary_address_street_2']   = @flowlink_customer['shipping_address']['address2']
      contact['primary_address_city']       = @flowlink_customer['shipping_address']['city']
      contact['primary_address_state']      = @flowlink_customer['shipping_address']['state']
      contact['primary_address_postalcode'] = @flowlink_customer['shipping_address']['zipcode']
      contact['primary_address_country']    = @flowlink_customer['shipping_address']['country']
    end
    if !@flowlink_customer['billing_address'].nil?
      contact['alt_address_street']         = @flowlink_customer['billing_address']['address1']
      contact['alt_address_street_2']       = @flowlink_customer['billing_address']['address2']
      contact['alt_address_city']           = @flowlink_customer['billing_address']['city']
      contact['alt_address_state']          = @flowlink_customer['billing_address']['state']
      contact['alt_address_postalcode']     = @flowlink_customer['billing_address']['zipcode']
      contact['alt_address_country']        = @flowlink_customer['billing_address']['country']
      contact['phone_home']                 = @flowlink_customer['billing_address']['phone']
      contact['phone_work']                 = @flowlink_customer['billing_address']['phone']
    end
    contact['phone_other']                = @flowlink_customer['shipping_address']['phone']
    contact['lead_source']                = 'Web Site'
    return contact
  end

end
