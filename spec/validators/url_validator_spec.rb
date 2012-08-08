require 'spec_helper'

describe "UrlValidator" do
  before(:each) do
    @validator = UrlValidator.new({:attributes => {}})
    @mock = mock('model')
    @mock.stub("errors").and_return([])
    @mock.errors.stub('[]').and_return({})
    @mock.errors[].stub('<<')
  end

  it "should accept http urls" do
    @mock.should_not_receive('errors')
    @validator.validate_each(@mock, "site", "http://www.facebook.com/Candidato.Legal")
    @validator.validate_each(@mock, "site", "http://www.twitter.com/fulano")
    @validator.validate_each(@mock, "site", "http://www.fulanodetal.gov.br")
  end

  it "should accept https urls" do
    @mock.should_not_receive('errors')
    @validator.validate_each(@mock, "email", "https://www.siteDoFulano.gov.br")
    @validator.validate_each(@mock, "email", "https://www.blogdofulano.wordpress.com.br")
  end

  it "should validate invalid urls" do
    @mock.errors[].should_receive('<<')
    @validator.validate_each(@mock, "email", "invalido")
    @validator.validate_each(@mock, "email", "www.fulano.gov")
    @validator.validate_each(@mock, "email", "htttp:/www.fulano.gov")
    @validator.validate_each(@mock, "site", "http://fulaninho.com/{B5A2}")
  end
end
