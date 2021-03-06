module ApiRequestsHandler
  class Request
    attr_accessor :method, :uri, :retry_count, :data, :headers, :response
    def initialize(method, url, retry_count, data, headers)
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
      http.use_ssl = uri.scheme == 'https'
      case method
      when :get, :delete
        uri.query = URI.encode_www_form(data)
        response = http.method(method).call(uri)
      when :post, :put, :patch
        response = http.method(method).call(uri, data.to_json)
      end
      parsed_response response
    end

    def parsed_response(response)
      # JSON.parse(response)
      response
    end
  end
end
