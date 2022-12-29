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
# File lib/rubygems/dependency.rb, line 250
def matches_spec? spec
  return false unless name === spec.name
  return true  if requirement.none?

  requirement.satisfied_by?(spec.version)
end
# File lib/rubygems/dependency.rb, line 119
def requirement
  return @requirement if defined?(@requirement) and @requirement

  # @version_requirements and @version_requirement are legacy ivar
  # names, and supported here because older gems need to keep
  # working and Dependency doesn't implement marshal_dump and
  # marshal_load. In a happier world, this would be an
  # attr_accessor. The horrifying instance_variable_get you see
  # below is also the legacy of some old restructurings.
  #
  # Note also that because of backwards compatibility (loading new
  # gems in an old RubyGems installation), we can't add explicit
  # marshaling to this class until we want to make a big
  # break. Maybe 2.0.
  #
  # Children, define explicit marshal and unmarshal behavior for
  # public classes. Marshal formats are part of your public API.

  # REFACTOR: See above

  if defined?(@version_requirement) && @version_requirement
    version = @version_requirement.instance_variable_get :@version
    @version_requirement  = nil
    @version_requirements = Gem::Requirement.new version
  end

  @requirement = @version_requirements if defined?(@version_requirements)
end

