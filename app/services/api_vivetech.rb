class ApiVivetech
  include HTTParty
  debug_output $stdout
  
  def self.login(args)
    response = HTTParty.post("#{base_url}/api/v1/sessions/login",body: args.to_json ,:headers => headers(''), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.validate_token(token)
    response = HTTParty.get("#{base_url}/api/v1/sessions/validate" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_products(token)
    response = HTTParty.get("#{base_url}/api/v1/products" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_product(args)
    response = HTTParty.get("#{base_url}/api/v1/products/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.create_product(args)
    response = HTTParty.post("#{base_url}/api/v1/products", body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_orders(token)
    response = HTTParty.get("#{base_url}/api/v1/orders" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_order(args)
    response = HTTParty.get("#{base_url}/api/v1/orders/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.create_order(args)
    response = HTTParty.post("#{base_url}/api/v1/orders", body: {data: args[:data]}.to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.base_url
    "#{ENV['API_VIVETECH']}"
  end
    
  def self.headers(token)
    {
      'Authorization' => token,
      'Content-Type'  => 'application/json',
      "User-Agent"    => "DashboardVivetech/2.0"
    }
  end

end