require "vcr"
require "./lib/linguist"

VCR.configure do |vcr|
  vcr.cassette_library_dir = "spec/cassettes"
  vcr.hook_into :webmock
end
