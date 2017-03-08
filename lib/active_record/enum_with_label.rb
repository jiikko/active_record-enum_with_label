require "active_record/enum_with_label/version"
require 'active_record'

module ActiveRecord
  module EnumWithLabel
    extend ActiveSupport::Concern

    included do
      def self.enum_with_label(name, hash)
        first_value = hash.values.first
        case
        when first_value.is_a?(String)
          self.define_singleton_method("#{name}_labels") do
            hash.values
          end
          self.enum(name => hash.keys)
          self.instance_eval do
            self.send(:define_method, "#{name}_label") { hash[status.to_sym] }
          end
        when first_value.is_a?(Hash)
        else
          raise('Hello unexpect object!')
        end
      end
    end
  end
end

if defined?(Rails)
  class Railtie < Rails::Railtie
    initializer 'initialize huwahuwa_state' do
      ActiveSupport.on_load(:active_record) do
        ::ActiveRecord::Base.send(:include, ActiveRecord::EnumWithLabel)
      end
    end
  end
else
  ::ActiveRecord::Base.send(:include, ActiveRecord::EnumWithLabel)
end
