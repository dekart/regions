Regions plugin for Rails
========================

Regions plugin allows you to specify regions in your templates that can be customized
by installed plugins.

Usage example
-------------

In your template:

    <% region(:some_block) do %>
      This is default block value
    <% end %>

Helper in your plugin:

    module MyHelpers
      def self.included(base)
        # Adds result of first_helper before default block
        base.regions.prepend(:block_1, :first_helper)

        # Adds result of second_helper after default block
        base.regions.append(:block_2, :second_helper)

        # Replaces default block with result of third_helper
        base.regions.replace(:block_3, :third_helper)
      end

      def first_helper
        "Content before block"
      end

      def second_helper
        "content after block"
      end

      def third_helper
        link_to(some_object.name, some_object)
      end
    end

You can also add additional parameters to specify region context. They will be
passed to helpers:

    <% region(:some_block, @user, ["some", "array"], {:any => "hash"}) do %>
      ...
    <% end %>

Copyright (c) 2008 "Alexey Dmitriev":http://www.html-blog.ru

Contact Email: rene.dekart@gmail.com
