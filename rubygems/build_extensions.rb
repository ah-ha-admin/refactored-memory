File lib/rubygems/ext/builder.rb, line 24
def self.class_name
  name =~ /Ext::(.*)Builder/
  $1.downcase
end
# File lib/rubygems/ext/builder.rb, line 24
def self.class_name
  name =~ /Ext::(.*)Builder/
  $1.downcase
end
# File lib/rubygems/ext/builder.rb, line 29
def self.make(dest_path, results)
  unless File.exist? 'Makefile' then
    raise Gem::InstallError, 'Makefile not found'
  end

  # try to find make program from Ruby configure arguments first
  RbConfig::CONFIG['configure_args'] =~ /with-make-prog\=(\w+)/
  make_program = ENV['MAKE'] || ENV['make'] || $1
  unless make_program then
    make_program = (/mswin/ =~ RUBY_PLATFORM) ? 'nmake' : 'make'
  end

  destdir = '"DESTDIR=%s"' % ENV['DESTDIR'] if RUBY_VERSION > '2.0'

  ['clean', '', 'install'].each do |target|
    # Pass DESTDIR via command line to override what's in MAKEFLAGS
    cmd = [
      make_program,
      destdir,
      target
    ].join(' ').rstrip
    begin
      run(cmd, results, "make #{target}".rstrip)
    rescue Gem::InstallError
      raise unless target == 'clean' # ignore clean failure
    end
  end
end
# File lib/rubygems/ext/builder.rb, line 100
def initialize spec, build_args = spec.build_args
  @spec       = spec
  @build_args = build_args
  @gem_dir    = spec.full_gem_path

  @ran_rake   = nil
end
# File lib/rubygems/ext/builder.rb, line 58
def self.redirector
  '2>&1'
end
# File lib/rubygems/ext/builder.rb, line 62
def self.run(command, results, command_name = nil)
  verbose = Gem.configuration.really_verbose

  begin
    # TODO use Process.spawn when ruby 1.8 support is dropped.
    rubygems_gemdeps, ENV['RUBYGEMS_GEMDEPS'] = ENV['RUBYGEMS_GEMDEPS'], nil
    if verbose
      puts("current directory: #{Dir.pwd}")
      puts(command)
      system(command)
    else
      results << "current directory: #{Dir.pwd}"
      results << command
      results << %x`#{command} #{redirector}`
    end
  ensure
    ENV['RUBYGEMS_GEMDEPS'] = rubygems_gemdeps
  end

  unless $?.success? then
    results << "Building has failed. See above output for more information on the failure." if verbose

    exit_reason =
      if $?.exited? then
        ", exit code #{$?.exitstatus}"
      elsif $?.signaled? then
        ", uncaught signal #{$?.termsig}"
      end

    raise Gem::InstallError, "#{command_name || class_name} failed#{exit_reason}"
  end
end
# File lib/rubygems/ext/builder.rb, line 181
def build_extensions
  return if @spec.extensions.empty?

  if @build_args.empty?
    say "Building native extensions.  This could take a while..."
  else
    say "Building native extensions with: '#{@build_args.join ' '}'"
    say "This could take a while..."
  end

  dest_path = @spec.extension_dir

  FileUtils.rm_f @spec.gem_build_complete_path

  @ran_rake = false # only run rake once

  @spec.extensions.each do |extension|
    break if @ran_rake

    build_extension extension, dest_path
  end

  FileUtils.touch @spec.gem_build_complete_path
end
