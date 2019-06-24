# frozen_string_literal: true

%w[version messages].each do |name|
  require "lite/errors/#{name}"
end
