module Regions
  class Collection
    attr_accessor_with_default :regions, {}

    def append(key, helper)
      register(key, :after, helper)
    end

    def prepend(key, helper)
      register(key, :before, helper)
    end

    def replace(key, helper)
      register(key, :instead, helper)
    end

    def register(key, position, helper)
      regions[key.to_sym] ||= {}
      regions[key.to_sym][position] ||= []

      regions[key.to_sym][position] << helper
      regions[key.to_sym][position].uniq!
    end

    def hooks_for(key, block)
      hooks = regions[key.to_sym]

      return [block] if hooks.nil?
      return [hooks[:instead].last] if hooks[:instead] and hooks[:instead].any?

      return (hooks[:before].to_a + [block] + hooks[:after].to_a).compact
    end
  end
end