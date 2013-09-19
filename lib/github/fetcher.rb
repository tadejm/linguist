require "net/http"
require "json"


module Github
  class Fetcher
    attr_reader :username

    def initialize username
      @username = username
    end

    def repos
      get_repos user_repos_url
    end

    def languages
      repos.map(&:language)
    end

    private

    def get_repos url
      response = Net::HTTP.get_response(url)
      response.code == "200" ? parse(response.body) : []
    end

    def parse body
      json_response = JSON.parse body
      json_response.map{ |repo| Repository.new repo['language'] }
    end

    def user_repos_url
      URI "#{github_base_url}/users/#{username}/repos"
    end

    def github_base_url
      "https://api.github.com"
    end
  end
end
