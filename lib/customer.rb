class Customer

  attr_accessor :sugar_contact_id

  def initialize(wombat_customer = {})
    @wombat_customer = wombat_customer

    if @wombat_customer['firstname'].nil? || @wombat_customer['firstname'].empty?
      if !@wombat_customer['billing_address'].nil?
        @wombat_customer['firstname'] = @wombat_customer['billing_address']['firstname']
      elsif !@wombat_customer['shipping_address'].nil?
        @wombat_customer['firstname'] = @wombat_customer['shipping_address']['firstname']
      else
        @wombat_customer['firstname'] = 'Empty'
      end
    end
    if @wombat_customer['lastname'].nil? || @wombat_customer['lastname'].empty?
      if !@wombat_customer['billing_address'].nil?
        @wombat_customer['lastname'] = @wombat_customer['billing_address']['lastname']
      elsif !@wombat_customer['shipping_address'].nil?
        @wombat_customer['lastname'] = @wombat_customer['shipping_address']['lastname']
      else
        @wombat_customer['lastname'] = 'Empty'
      end
    end
  end

  def wombat_id
    @wombat_customer['id']
  end

  def email
    @wombat_customer['email']
  end

  def sugar_account
    account = Hash.new
    account['name']        = "#{@wombat_customer['firstname']} #{@wombat_customer['lastname']}"
    account['description'] = "#{@wombat_customer['firstname']} #{@wombat_customer['lastname']}"
    account['email']       = [{
      'email_address' => @wombat_customer['email'],
      'primary_address' => true
    }]
    if !@wombat_customer['shipping_address'].nil?
      account['shipping_address_street']     = @wombat_customer['shipping_address']['address1']
      account['shipping_address_street_2']   = @wombat_customer['shipping_address']['address2']
      account['shipping_address_city']       = @wombat_customer['shipping_address']['city']
      account['shipping_address_state']      = @wombat_customer['shipping_address']['state']
      account['shipping_address_postalcode'] = @wombat_customer['shipping_address']['zipcode']
      account['shipping_address_country']    = @wombat_customer['shipping_address']['country']
      account['phone_alternate']             = @wombat_customer['shipping_address']['phone']
    end
    if !@wombat_customer['billing_address'].nil?
      account['billing_address_street']      = @wombat_customer['billing_address']['address1']
      account['billing_address_street_2']    = @wombat_customer['billing_address']['address2']
      account['billing_address_city']        = @wombat_customer['billing_address']['city']
      account['billing_address_state']       = @wombat_customer['billing_address']['state']
      account['billing_address_postalcode']  = @wombat_customer['billing_address']['zipcode']
      account['billing_address_country']     = @wombat_customer['billing_address']['country']
      account['phone_office']                = @wombat_customer['billing_address']['phone']
    end
    account['lead_source']                 = 'Web Site'
    return account
  end

  def sugar_contact
    contact = Hash.new
    contact['first_name']  = @wombat_customer['firstname']
    contact['last_name']   = @wombat_customer['lastname']
    contact['description'] = "#{@wombat_customer['firstname']} #{@wombat_customer['lastname']}"
    contact['email']       = [{
      'email_address' => @wombat_customer['email'],
      'primary_address' => true
    }]
    if !@wombat_customer['shipping_address'].nil?
      contact['primary_address_street']     = @wombat_customer['shipping_address']['address1']
      contact['primary_address_street_2']   = @wombat_customer['shipping_address']['address2']
      contact['primary_address_city']       = @wombat_customer['shipping_address']['city']
      contact['primary_address_state']      = @wombat_customer['shipping_address']['state']
      contact['primary_address_postalcode'] = @wombat_customer['shipping_address']['zipcode']
      contact['primary_address_country']    = @wombat_customer['shipping_address']['country']
    end
    if !@wombat_customer['billing_address'].nil?
      contact['alt_address_street']         = @wombat_customer['billing_address']['address1']
      contact['alt_address_street_2']       = @wombat_customer['billing_address']['address2']
      contact['alt_address_city']           = @wombat_customer['billing_address']['city']
      contact['alt_address_state']          = @wombat_customer['billing_address']['state']
      contact['alt_address_postalcode']     = @wombat_customer['billing_address']['zipcode']
      contact['alt_address_country']        = @wombat_customer['billing_address']['country']
      contact['phone_home']                 = @wombat_customer['billing_address']['phone']
      contact['phone_work']                 = @wombat_customer['billing_address']['phone']
    end
    contact['phone_other']                = @wombat_customer['shipping_address']['phone']
    contact['lead_source']                = 'Web Site'
    return contact
  end

end
