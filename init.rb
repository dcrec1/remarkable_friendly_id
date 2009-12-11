if RAILS_ENV == "test"

  require 'spec'
  require 'spec/rails'
  require 'remarkable_rails'

  Remarkable.add_locale RAILS_ROOT + "/vendor/plugins/remarkable_friendly_id/locale/en.yml"

  require File.join(File.dirname(__FILE__), "lib", "remarkable_friendly_id")
end
