module Linguist
  class User
    attr_reader :username, :language

    def initialize username
      @username = username
      @language = favourite_language
    end

    def to_s
      if language
        "#{username} – #{language} programmer"
      else
        "User #{username} doesn't exist or has 0 public repositories"
      end
    end

    private

    def favourite_language
      fetcher = Fetcher.new(username)
      Analyser.new(fetcher).favourite_language
    end
  end
end
