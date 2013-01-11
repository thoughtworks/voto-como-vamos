require "spec_helper"

describe UserMailer do
  describe "pesquisa" do
    it "should send the pesquisa without problems" do
      user_email = "bla@example.com"
      expect { UserMailer.pesquisa user_email }.to_not raise_error
    end
  end
end
