require "toml-ruby/parser"
require "toml-ruby/version"

module Toml
  def self.load(io)
    Parser.new.parse(io)
  end
end
