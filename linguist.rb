#! /usr/bin/env ruby

require "optparse"

require_relative "lib/linguist"

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


puts "#{Linguist::User.new(options[:username])}"
