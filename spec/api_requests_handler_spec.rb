require 'spec_helper'

RSpec.describe HttpClient do
  it 'has a version number' do
    expect(HttpClient::VERSION).not_to be nil
  end
end
