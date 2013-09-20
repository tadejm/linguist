require "spec_helper"

module Linguist
  describe Fetcher do
    let(:username) { "tadejm" }
    let(:repo)     { Repository.new lang_name }
    let(:lang_name){ "Ruby" }

    describe "#repos" do
      it "returns an Array of Repositories" do
        VCR.use_cassette("data_on_success") do
          repos_data = Fetcher.new(username).repos
          expect(repos_data).to include(repo)
        end
      end
    end

    describe "#languages" do
      it "returns an Array of programming languages" do
        VCR.use_cassette("data_on_success") do
          languages = Fetcher.new(username).languages
          expect(languages).to include(lang_name)
        end
      end
    end
  end
end
