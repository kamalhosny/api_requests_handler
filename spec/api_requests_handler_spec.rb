require 'spec_helper'

RSpec.describe HttpClient do
  it 'has a version number' do
    expect(HttpClient::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
