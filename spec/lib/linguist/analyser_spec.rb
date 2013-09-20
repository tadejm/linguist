require "spec_helper"

module Linguist
  describe Analyser do
    let(:fav_lang)  { "Ruby" }
    let(:languages) { %w(Ruby Java Ruby Ruby Javascript) }
    let(:fetcher)   { OpenStruct.new languages: languages }

    it "provides user's favourite language" do
      analyser = Analyser.new(fetcher)
      expect(analyser.favourite_language).to eq(fav_lang)
    end
  end
end
