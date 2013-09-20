require "net/http"
require "json"

module Linguist
  Repository = Struct.new :language
  class Fetcher
    attr_reader :username

    def initialize username
      @username = username
    end

    def repos
      fetch_repos
      parse_repos
    end

    def languages
      repos.map(&:language)
    end

    private

    def fetch_repos
      @response ||= Net::HTTP.get_response(user_repos_url)
    end

    def parse_repos
      json_response = JSON.parse @response.body
      json_response.map{ |repo| Repository.new repo['language'] }
    rescue TypeError
      []
    end

    def user_repos_url
      URI "#{github_base_url}/users/#{username}/repos"
    end

    def github_base_url
      "https://api.github.com"
    end
  end
end
