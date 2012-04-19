module Shomen
  #
  module Rdoc
    #
    def self.metadata
      @metadata ||= (
        require 'yaml'
        YAML.load_file(File.dirname(__FILE__) + '/shomen-rdoc.yml')
      )
    end

    #
    def self.const_missing(name)
      metadata[name.to_s.downcase] || super(name)
    end
  end
end

require 'shomen/generator'
#require 'shomen-rdoc/rdoc'
require 'shomen-rdoc/generator'
require 'shomen-rdoc/command'

