# encoding: utf-8

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "shoulda-context"

reporter_options = { color: true  }
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(reporter_options)
