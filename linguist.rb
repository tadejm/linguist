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

  opts.on "-h", "--help", "Shows usage" do |h|
    warn opts
    exit
  end
end.parse!


if options[:username].nil?
  abort "Missing argument: USERNAME"
end

$username  = options[:username]
$language  = nil
$languages = Hash.new do |hash, missing_key|
  hash[missing_key] = 0
end

# GET /users/:user/repos
def repos
  warn "Gathering info about #{$username}..."

  path = "/users/#{$username}/repos?"
  response = get path

  if response.is_a? Net::HTTPSuccess
    parse_repos response.body
  else
    puts response.inspect
    abort "Could not fetch repositories for user #{$username}."
  end
end

# GET /repos/:owner/:repo/languages
def analyze repo
  path = "/repos/#{$username}/#{repo}/languages"

  response = get path
  parse_languages response.body
end

def parse_languages response
  json_response = parse response

  json_response.each_pair do |name, lines|
    $languages[name] += lines
  end
end

def parse_repos response
  json_response = parse response
  json_response.map{|repo| repo['name'] }
end

def parse response
  json = JSON.parse response

  if json.nil? or json == ""
    abort "There was an error fetching data from Github."
  else
    json
  end
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

def most_lines_written_in
  $language ||= $languages.max_by{|k,v| v}
end

def lines
  most_lines_written_in.last
end

def language_name
  most_lines_written_in.first
end

for repo in repos
  analyze repo
end

# puts "\nUser #{$username} has written #{lines} of #{language_name} code."
puts "#{$username} is a #{language_name} programmer."
