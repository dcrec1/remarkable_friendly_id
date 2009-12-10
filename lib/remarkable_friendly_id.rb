require 'remarkable_activerecord'
require 'matchers/have_friendly_id_matcher'

if defined?(Spec::Rails)
  Remarkable.include_matchers!(Remarkable::FriendlyId, Spec::Rails::Example::ModelExampleGroup)
else
  Remarkable.include_matchers!(Remarkable::FriendlyId, Spec::Example::ExampleGroup)
end

Remarkable.add_locale(File.dirname(__FILE__) + '/../locale/en.yml')
