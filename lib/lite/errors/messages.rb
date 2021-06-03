# frozen_string_literal: true

module Lite
  module Errors
    class Messages

      attr_reader :errors

      def initialize
        @errors = {}
      end

      def [](key)
        return [] unless key?(key)

        @errors[key]
      end

      alias messages_for []

      def []=(key, value)
        @errors[key] ||= []
        @errors[key] << value
        @errors[key].uniq!
      end

      alias add []=

      def added?(key, val)
        return false unless key?(key)

        @errors[key].include?(val)
      end

      alias of_kind? added?

      def clear
        @errors.clear
      end

      def delete(key)
        @errors.delete(key)
      end

      # :nocov:
      def each
        @errors.each_key do |key|
          @errors[key].each { |val| yield(key, val) }
        end
      end
      # :nocov:

      def empty?
        @errors.empty?
      end

      alias blank? empty?

      def full_message(key, value)
        "#{key} #{value}"
      end

      def full_messages
        @errors.each_with_object([]) do |(key, arr), memo|
          arr.each { |val| memo << full_message(key, val) }
        end
      end

      alias to_a full_messages

      def full_messages_for(key)
        return [] unless key?(key)

        @errors[key].map { |val| full_message(key, val) }
      end

      def key?(key)
        @errors.key?(key)
      end

      alias has_key? key?
      alias include? key?

      def keys
        @errors.keys
      end

      alias attribute_names keys

      def merge!(hash)
        @errors.merge!(hash) do |_, arr1, arr2|
          arr3 = arr1 + arr2
          arr3.uniq!
          arr3
        end
      end

      def present?
        !blank?
      end

      def size
        @errors.size
      end

      alias count size

      def slice!(*keys)
        keys.each { |key| delete(key) }
        @errors
      end

      # rubocop:disable Style/OptionalBooleanParameter
      def to_hash(full_messages = false)
        return @errors unless full_messages

        @errors.each_with_object({}) do |(key, arr), memo|
          memo[key] = arr.map { |val| full_message(key, val) }
        end
      end
      # rubocop:enable Style/OptionalBooleanParameter

      alias messages to_hash
      alias group_by_attribute to_hash
      alias as_json to_hash

      def values
        @errors.values
      end

    end
  end
end
