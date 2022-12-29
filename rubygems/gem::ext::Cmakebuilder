File lib/rubygems/ext/cmake_builder.rb, line 4
def self.build(extension, directory, dest_path, results, args=[], lib_dir=nil)
  unless File.exist?('Makefile') then
    cmd = "cmake . -DCMAKE_INSTALL_PREFIX=#{dest_path}"
    cmd << " #{Gem::Command.build_args.join ' '}" unless Gem::Command.build_args.empty?

    run cmd, results
  end

  make dest_path, results

  results
end
class Gem::Ext::CmakeBuilder

Public Class Methods

build(extension, directory, dest_path, results, args=[], lib_dir=nil)
