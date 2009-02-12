module Regions
  module Helpers
    def self.included(base)
      base.cattr_accessor :regions
      
      base.regions = Regions::Collection.new
    end

    def region(key, *args, &block)
      content = ""

      self.class.regions.hooks_for(key, block).each do |hook|
        if hook == block
          content << capture(&block)
        else 
          content << send(hook, *args).to_s
        end
      end

      concat(content, block.binding)
    end
  end
end