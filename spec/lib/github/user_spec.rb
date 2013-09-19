require "spec_helper"

module Github
  describe User do
    let(:username) { "tadejm" }
    let(:user) { User.new username }


    it "prints out the username and language" do
      VCR.use_cassette("data_on_success") do
        statement = "tadejm – Ruby programmer"
        expect(user.to_s).to eq statement
      end
    end

    it "notifies when user's not found or has 0 repos" do
      VCR.use_cassette("something_went_wrong") do
        username = "blalbalblamfkldfa"
        user = User.new username
        statement = "User #{username} doesn't exist or has 0 public repositories"
        expect(user.to_s).to eq statement
      end
    end
  end
end
