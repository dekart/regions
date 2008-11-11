module Regions
  module Helpers
    def self.included(base)
      base.cattr_accessor :regions
      
      base.regions = Regions::Collection.new
    end

    def region(key, *args, &block)
      content = ""

      self.class.regions.hooks_for(key, block).each do |hook|
        content << hook == block ? capture(&block) : send(hook, *args)
      end

      concat(content, block.binding)
    end
  end
end