require "bundler"
Bundler.require

require_relative "models/post"

get "/" do
  "Hello world"
end
