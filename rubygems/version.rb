# frozen_string_literal: true

module ServiceActor
  VERSION = "3.5.0"
end
# frozen_string_literal: true

module Rails
  # Returns the currently loaded version of Rails as a <tt>Gem::Version</tt>.
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 7
    MINOR = 1
    TINY  = 0
    PRE   = "alpha"

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".")
  end
end
