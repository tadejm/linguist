require "spec_helper"

module Github
  describe Analyser do
    let(:repos)     { double }
    let(:username)  { double }
    let(:fetcher)   { double }
    let(:languages) { %w(Ruby Java Ruby Ruby Javascript) }
    let(:fav_lang)  { "Ruby" }

    it "provides user's favourite language" do
      allow(Fetcher).to receive(:new).with(username).and_return fetcher
      allow(fetcher).to receive(:languages).and_return languages

      analyser = Analyser.new(username)
      expect(analyser.favourite_language).to eq(fav_lang)
    end
  end
end
