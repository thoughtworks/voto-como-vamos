# encoding: utf-8
require 'spec_helper'
require 'rack/test'

describe Rack::FacebookRequestTranslator do
  include Rack::Test::Methods

  let(:inner_app) do
    lambda do |env|
      if env['REQUEST_METHOD'] == 'GET'
        [200, {'Content-Type' => 'text/plain'}, ['Is a GET']]
      else
        [200, {'Content-Type' => 'text/plain'}, ['Is a POST']]
      end
    end
  end

  let(:app) { Rack::FacebookRequestTranslator.new(inner_app) }

  # Facebook send all request to the iframe as POST
  # and this mess with our RESTful routes
  # In order to avoid this issue the middleware will translate
  # only the request with the 'signed_request' params.
  # It will NOT affect POST requests inside the iframe

  it 'changes the request method to GET if it cames from Facebook' do
    post '/foo', signed_request: 'xyz'
    last_response.body.should eq('Is a GET')
  end

  it 'maintain the request unchanged if it cames from another part' do
    post '/foo'
    last_response.body.should eq('Is a POST')
  end
end
