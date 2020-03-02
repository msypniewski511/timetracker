module RescuedApartmentMiddleware
  def call(*args)
    begin
      super
    rescue Apartment::TenantNotFound
      Rails.logger.error "ERROR: Apartment Tenant not found: #{Apartment::Tenant.current.inspect}"
      request = Rack::Request.new('/')
      # return
      # redirect_to "/"
      return [404, {"Content-Type" => "text/html"}, ["#{File.read(Rails.root.to_s + '/public/404.html')}"] ]
    end
  end
end