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
          self.enum(
            name => (first_value.key?(:value) ? hash.transform_values { |h| h[:value] } : hash.keys)
          )
          first_value.keys.each do |key|
            next if key == :value
            self.define_singleton_method("#{name}_#{key.to_s.pluralize}") do
              hash.transform_values { |x| x[key] }.values
            end
            self.instance_eval do
              self.send(:define_method, "#{name}_#{key}") { hash[public_send(name).to_sym][key] }
            end
          end
        else
          raise('Hello unexpect object!')
        end
      end
    end
  end
end
