require 'action_policy/rspec/dsl'
require 'money-rails/test_helpers'
require 'test_prof/recipes/rspec/before_all'
require "test_prof/recipes/rspec/factory_default"

RSpec::Matchers.define_negated_matcher :not_change, :change
