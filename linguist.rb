#! /usr/bin/env ruby

require "optparse"
require "json"
require "net/http"

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: #$0 -u username"

  opts.on "-u", "--username USERNAME", "Github username (required)" do |u|
    options[:username] = u
  end

  opts.on "-h", "--help", "Shows usage" do
    warn opts
    exit
  end
end.parse!

abort "Missing argument: USERNAME" if options[:username].nil?

$username  = options[:username]
$languages = Hash.new{ |hash, missing_key| hash[missing_key] = 0 }

# GET /users/:user/repos
def languages
  warn "Gathering info about #{$username}..."

  response = get "/users/#{$username}/repos?"
  repo_language(response.body) if success?(response)
end

def repo_language body
  parse(body).map{ |d| d['language'] }
end

def analyze repos
  repos.each { |name| $languages[name] += 1 }
end

def parse response
  json = JSON.parse response
  abort "There was an error fetching data from Github." if json.nil? or json == ""
  json
end

def success? response
  response.is_a?(Net::HTTPSuccess) ? true : abort("Could not fetch repositories for user #{$username}.")
end

def get path
  Net::HTTP.get_response uri(path)
end

def uri path
  URI "#{url}#{path}"
end

def url
  "https://api.github.com"
end

def favourite_language
  $languages.max_by{ |k,v| v }
end

def language_name
  favourite_language.first
end

analyze languages

puts "#{$username} – #{language_name} programmer."
