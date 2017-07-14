module ApiRequestsHandler
  class Request
    attr_accessor :method, :uri, :retry_count, :data, :headers
    def initilaize(method, url, retry_count, data, headers)
      @method = method
      @uri = URI(url)
      @retry_count = retry_count
      @data = data
      @headers = headers
      @response = execute_request
    end

    private

    def execute_request
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = http.schema == 'https'
      case method
      when :get, :delete
        uri.query = URI.encode_www_form(data)
        response = http.method(method).call(uri)
      when :post, :put, :patch
        response = http.method(method).call(uri, data.to_json)
      end
      response
    end
  end
end
