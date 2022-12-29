# File lib/rubygems/dependency.rb, line 37
def initialize name, *requirements
  case name
  when String then # ok
  when Regexp then
    msg = ["NOTE: Dependency.new w/ a regexp is deprecated.",
           "Dependency.new called from #{Gem.location_of_caller.join(":")}"]
    warn msg.join("\n") unless Gem::Deprecate.skip
  else
    raise ArgumentError,
          "dependency name must be a String, was #{name.inspect}"
  end

  type         = Symbol === requirements.last ? requirements.pop : :runtime
  requirements = requirements.first if 1 == requirements.length # unpack

  unless TYPES.include? type
    raise ArgumentError, "Valid types are #{TYPES.inspect}, " +
                         "not #{type.inspect}"
  end

  @name        = name
  @requirement = Gem::Requirement.create requirements
  @type        = type
  @prerelease  = false

  # This is for Marshal backwards compatibility. See the comments in
  # +requirement+ for the dirty details.

  @version_requirements = @requirement
end
