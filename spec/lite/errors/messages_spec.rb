# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Errors::Messages do
  let(:klass) { described_class.new }

  describe '.initialize' do
    it 'to be []' do
      expect(klass.errors).to eq({})
    end
  end

  describe '.[]' do
    it 'to be []' do
      expect(klass[:field]).to eq([])
    end

    it 'to be ["error message"]' do
      klass.add(:field, 'error message')

      expect(klass[:field]).to eq(['error message'])
    end
  end

  describe '.add' do
    it 'to be { field: ["error message", "other message"] }' do
      2.times { klass.add(:field, 'error message') }
      klass.add(:field, 'other message')

      expect(klass.errors).to eq(field: ['error message', 'other message'])
    end
  end

  describe '.added?' do
    before { klass.add(:field, 'error message') }

    it 'to be true' do
      expect(klass.added?(:field, 'error message')).to eq(true)
    end

    it 'to be false with missing key' do
      expect(klass.added?(:other, 'error message')).to eq(false)
    end

    it 'to be false with missing message' do
      expect(klass.added?(:field, 'other message')).to eq(false)
    end
  end

  describe '.clear' do
    it 'to be {}' do
      klass.add(:field, 'error message')

      expect(klass.clear).to eq({})
    end
  end

  describe '.delete' do
    it 'to be "error message"' do
      klass.add(:field, 'error message')

      expect(klass.delete(:field)).to eq(['error message'])
    end
  end

  describe '.empty?' do
    it 'to be true' do
      expect(klass.empty?).to eq(true)
    end

    it 'to be false' do
      klass.add(:field, 'error message')

      expect(klass.empty?).to eq(false)
    end
  end

  describe '.full_message' do
    it 'to be "field error message"' do
      expect(klass.full_message(:field, 'error message')).to eq('field error message')
    end
  end

  describe '.full_messages' do
    it 'to be "field error message"' do
      klass.add(:field, 'error message')
      klass.add(:field, 'other message')

      expect(klass.full_messages).to eq(['field error message', 'field other message'])
    end
  end

  describe '.full_messages_for' do
    it 'to be []' do
      expect(klass.full_messages_for(:field)).to eq([])
    end

    it 'to be ["field error message"]' do
      klass.add(:field, 'error message')
      klass.add(:other, 'other message')

      expect(klass.full_messages_for(:field)).to eq(['field error message'])
    end
  end

  describe '.key?' do
    it 'to be false' do
      expect(klass.key?(:field)).to eq(false)
    end

    it 'to be true' do
      klass.add(:field, 'error message')

      expect(klass.key?(:field)).to eq(true)
    end
  end

  describe '.keys' do
    it 'to be [:field]' do
      klass.add(:field, 'error message')

      expect(klass.keys).to eq(%i[field])
    end
  end

  # rubocop:disable Performance/RedundantMerge
  describe '.merge!' do
    it 'to be { field: ["error message", "other message"] }' do
      # Skip fasterer error: Hash#merge!

      klass.add(:field, 'error message')
      klass.merge!(field: ['error message'])
      klass.merge!(field: ['other message'])

      expect(klass.errors).to eq(field: ['error message', 'other message'])
    end
  end
  # rubocop:enable Performance/RedundantMerge

  describe '.present?' do
    it 'to be false' do
      expect(klass.present?).to eq(false)
    end

    it 'to be true' do
      klass.add(:field, 'error message')

      expect(klass.present?).to eq(true)
    end
  end

  describe '.size' do
    it 'to be 0' do
      expect(klass.size).to eq(0)
    end

    it 'to be 1' do
      klass.add(:field, 'error message')

      expect(klass.size).to eq(1)
    end
  end

  describe '.slice!' do
    it 'to be {}' do
      klass.add(:field, 'error message')

      expect(klass.slice!(:field)).to eq({})
    end
  end

  describe '.to_hash' do
    before { klass.add(:field, 'error message') }

    it 'to be { field: ["error message"] }' do
      expect(klass.to_hash).to eq(field: ['error message'])
    end

    it 'to be { field: ["field error message"] }' do
      expect(klass.to_hash(true)).to eq(field: ['field error message'])
    end
  end

  describe '.values' do
    it 'to be [["error message"]]' do
      klass.add(:field, 'error message')

      expect(klass.values).to eq([['error message']])
    end
  end

end
