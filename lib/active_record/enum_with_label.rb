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
          self.enum_with_label(
            name,
            hash.transform_values { |h| { label: h } }
          )
        when first_value.is_a?(Hash)
          self.enum(name => hash.keys)
          using_keys = hash.values.first.keys
          using_keys.each do |key|
            self.define_singleton_method("#{name}_#{key.to_s.pluralize}") do
              hash.transform_values { |x| x[key] }.values
            end
            self.instance_eval do
              self.send(:define_method, "#{name}_#{key}") { hash[status.to_sym][key] }
            end
          end
        else
          raise('Hello unexpect object!')
        end
      end
    end
  end
end
