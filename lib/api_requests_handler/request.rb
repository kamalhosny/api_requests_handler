module ApiRequestsHandler
  class Request
    def initilaize(options: {})
      @action = options[:action]
      @uri = URI(url)
      @uri.query = URI.encode_www_form(options)
      @response = http_action
    end

    # def http_action
    #
    # end
  end
end


Request.new(method: 'get', headers: headers, body: body)
