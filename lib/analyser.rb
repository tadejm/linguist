Analyser = Struct.new :username do
  def favourite_language
    languages = Fetcher.new(username).languages
    languages.sort_by{ |lang| languages.grep(lang).length }.last
  end
end
