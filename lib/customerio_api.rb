# frozen_string_literal: true

require_relative 'customerio_api/version'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect('customerio_api' => 'CustomerioAPI')
loader.collapse("#{__dir__}/customerio_api/objects")
loader.collapse("#{__dir__}/customerio_api/resources")
# Zeitwerk doesn't support multiple classes in a single file
# https://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#one-file-one-constant-at-the-same-top-level
loader.ignore("#{__dir__}/customerio_api/errors.rb")
loader.setup

require 'customerio_api/errors'

module CustomerioAPI
end

