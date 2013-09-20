module Linguist
  Analyser = Struct.new :fetcher do
    def favourite_language
      languages = fetcher.languages
      languages.sort_by{ |lang| languages.grep(lang).length }.last
    end
  end
end
