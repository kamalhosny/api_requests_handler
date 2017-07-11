module ApiRequestsHandler
  class Handler
    def initilaize (options: {})
      @method = options[:method]
      @app_id = options[:app_id]
      @headers = options[:headers]
      @body = options[:body]
      @response = http_request
    end

    def http_request
      @request = Request.new()
    end
  end
end
