# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Errors::Messages do
  let(:klass) { described_class.new }

  describe '.initialize' do
    it 'returns []' do
      expect(klass.errors).to eq({})
    end
  end

  describe '.[]' do
    it 'returns []' do
      expect(klass[:field]).to eq([])
    end

    it 'returns ["error message"]' do
      klass.add(:field, 'error message')

      expect(klass[:field]).to eq(['error message'])
    end
  end

  describe '.add' do
    it 'returns { field: ["error message", "other message"] }' do
      2.times { klass.add(:field, 'error message') }
      klass.add(:field, 'other message')

      expect(klass.errors).to eq(field: ['error message', 'other message'])
    end
  end

  describe '.added?' do
    before { klass.add(:field, 'error message') }

    it 'returns true' do
      expect(klass.added?(:field, 'error message')).to eq(true)
    end

    it 'returns false with missing key' do
      expect(klass.added?(:other, 'error message')).to eq(false)
    end

    it 'returns false with missing message' do
      expect(klass.added?(:field, 'other message')).to eq(false)
    end
  end

  describe '.clear' do
    it 'returns {}' do
      klass.add(:field, 'error message')

      expect(klass.clear).to eq({})
    end
  end

  describe '.delete' do
    it 'returns "error message"' do
      klass.add(:field, 'error message')

      expect(klass.delete(:field)).to eq(['error message'])
    end
  end

  describe '.empty?' do
    it 'returns true' do
      expect(klass.empty?).to eq(true)
    end

    it 'returns false' do
      klass.add(:field, 'error message')

      expect(klass.empty?).to eq(false)
    end
  end

  describe '.full_message' do
    it 'returns "field error message"' do
      expect(klass.full_message(:field, 'error message')).to eq('field error message')
    end
  end

  describe '.full_messages' do
    it 'returns "field error message"' do
      klass.add(:field, 'error message')
      klass.add(:field, 'other message')

      expect(klass.full_messages).to eq(['field error message', 'field other message'])
    end
  end

  describe '.full_messages_for' do
    it 'returns []' do
      expect(klass.full_messages_for(:field)).to eq([])
    end

    it 'returns ["field error message"]' do
      klass.add(:field, 'error message')
      klass.add(:other, 'other message')

      expect(klass.full_messages_for(:field)).to eq(['field error message'])
    end
  end

  describe '.key?' do
    it 'returns false' do
      expect(klass.key?(:field)).to eq(false)
    end

    it 'returns true' do
      klass.add(:field, 'error message')

      expect(klass.key?(:field)).to eq(true)
    end
  end

  describe '.keys' do
    it 'returns [:field]' do
      klass.add(:field, 'error message')

      expect(klass.keys).to eq(%i[field])
    end
  end

  # rubocop:disable Performance/RedundantMerge
  describe '.merge!' do
    it 'returns { field: ["error message", "other message"] }' do
      # Skip fasterer error: Hash#merge!

      klass.add(:field, 'error message')
      klass.merge!(field: ['error message'])
      klass.merge!(field: ['other message'])

      expect(klass.errors).to eq(field: ['error message', 'other message'])
    end
  end
  # rubocop:enable Performance/RedundantMerge

  describe '.present?' do
    it 'returns false' do
      expect(klass.present?).to eq(false)
    end

    it 'returns true' do
      klass.add(:field, 'error message')

      expect(klass.present?).to eq(true)
    end
  end

  describe '.size' do
    it 'returns 0' do
      expect(klass.size).to eq(0)
    end

    it 'returns 1' do
      klass.add(:field, 'error message')

      expect(klass.size).to eq(1)
    end
  end

  describe '.slice!' do
    it 'returns {}' do
      klass.add(:field, 'error message')

      expect(klass.slice!(:field)).to eq({})
    end
  end

  describe '.to_hash' do
    before { klass.add(:field, 'error message') }

    it 'returns { field: ["error message"] }' do
      expect(klass.to_hash).to eq(field: ['error message'])
    end

    it 'returns { field: ["field error message"] }' do
      expect(klass.to_hash(true)).to eq(field: ['field error message'])
    end
  end

  describe '.values' do
    it 'returns [["error message"]]' do
      klass.add(:field, 'error message')

      expect(klass.values).to eq([['error message']])
    end
  end

end
