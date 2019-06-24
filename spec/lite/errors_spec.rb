# frozen_string_literal: true

RSpec.describe Lite::Errors do

  it 'returns a version number' do
    expect(Lite::Errors::VERSION).not_to be nil
  end

end
