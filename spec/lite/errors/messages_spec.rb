# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Errors::Messages do
  subject { Lite::Errors::Messages.new }

  describe '.initialize' do
    it 'returns []' do
      expect(subject.errors).to eq({})
    end
  end

  describe '.[]' do
    it 'returns []' do
      expect(subject[:field]).to eq([])
    end

    it 'returns ["error message"]' do
      subject.add(:field, 'error message')

      expect(subject[:field]).to eq(['error message'])
    end
  end

  describe '.add' do
    it 'returns { field: ["error message", "other message"] }' do
      2.times { subject.add(:field, 'error message') }
      subject.add(:field, 'other message')

      expect(subject.errors).to eq({ field: ['error message', 'other message'] })
    end
  end

  describe '.added?' do
    before { subject.add(:field, 'error message') }

    it 'returns true' do
      expect(subject.added?(:field, 'error message')).to eq(true)
    end

    it 'returns false with missing key' do
      expect(subject.added?(:other, 'error message')).to eq(false)
    end

    it 'returns false with missing message' do
      expect(subject.added?(:field, 'other message')).to eq(false)
    end
  end

  describe '.clear' do
    it 'returns {}' do
      subject.add(:field, 'error message')

      expect(subject.clear).to eq({})
    end
  end

  describe '.delete' do
    it 'returns {}' do
      subject.add(:field, 'error message')
      subject.delete(:field)

      expect(subject.errors).to eq({})
    end
  end

  describe '.empty?' do
    it 'returns true' do
      expect(subject.empty?).to eq(true)
    end

    it 'returns false' do
      subject.add(:field, 'error message')

      expect(subject.empty?).to eq(false)
    end
  end

  describe '.full_message' do
    it 'returns "field error message"' do
      expect(subject.full_message(:field, 'error message')).to eq('field error message')
    end
  end

  describe '.full_messages' do
    it 'returns "field error message"' do
      subject.add(:field, 'error message')
      subject.add(:field, 'other message')

      expect(subject.full_messages).to eq(['field error message', 'field other message'])
    end
  end

  describe '.full_messages_for' do
    it 'returns []' do
      expect(subject.full_messages_for(:field)).to eq([])
    end

    it 'returns ["field error message"]' do
      subject.add(:field, 'error message')
      subject.add(:other, 'other message')

      expect(subject.full_messages_for(:field)).to eq(['field error message'])
    end
  end

  describe '.key?' do
    it 'returns false' do
      expect(subject.key?(:field)).to eq(false)
    end

    it 'returns true' do
      subject.add(:field, 'error message')

      expect(subject.key?(:field)).to eq(true)
    end
  end

  describe '.keys' do
    it 'returns [:field]' do
      subject.add(:field, 'error message')

      expect(subject.keys).to eq(%i[field])
    end
  end

  describe '.merge!' do
    it 'returns { field: ["error message", "other message"] }' do
      subject.add(:field, 'error message')
      subject.merge!(field: ['error message'])
      subject.merge!(field: ['other message'])

      expect(subject.errors).to eq({ field: ['error message', 'other message'] })
    end
  end

  describe '.present?' do
    it 'returns false' do
      expect(subject.present?).to eq(false)
    end

    it 'returns true' do
      subject.add(:field, 'error message')

      expect(subject.present?).to eq(true)
    end
  end

  describe '.size' do
    it 'returns 0' do
      expect(subject.size).to eq(0)
    end

    it 'returns 1' do
      subject.add(:field, 'error message')

      expect(subject.size).to eq(1)
    end
  end

  describe '.to_hash' do
    before { subject.add(:field, 'error message') }

    it 'returns { field: ["error message"] }' do
      expect(subject.to_hash).to eq({ field: ["error message"] })
    end

    it 'returns { field: ["field error message"] }' do
      expect(subject.to_hash(true)).to eq({ field: ["field error message"] })
    end
  end

  describe '.values' do
    it 'returns [["error message"]]' do
      subject.add(:field, 'error message')

      expect(subject.values).to eq([['error message']])
    end
  end

end
