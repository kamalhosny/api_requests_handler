module ApiRequestsHandler
  class Request
    ## Attributes
    attr_accessor :method, :uri, :retry_count, :data, :headers, :response

    ## Constructor
    def initialize(method, url, retry_count, data, headers)
      @method = method
      @uri = URI(url)
      @retry_count = retry_count
      @data = data
      @headers = headers
      @response = execute_request
    end

    ## Instance Methods
    def parsed_response
      JSON.parse(response.body)
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

      return response if response.is_a? Net::HTTPSuccess
    end
  end
end
