require 'dotenv/load'
require 'net/http'
require 'json'
require 'logger'

## iterate over files inside http_client directory and require them.
%w[version request execute].each do |file|
  require File.join(File.dirname(__FILE__), 'http_client', file)
end

module HttpClient
end
