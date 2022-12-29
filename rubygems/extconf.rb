# File lib/rubygems/ext/ext_conf_builder.rb, line 13
def self.build(extension, directory, dest_path, results, args=[], lib_dir=nil)
  # relative path required as some versions of mktmpdir return an absolute
  # path which breaks make if it includes a space in the name
  tmp_dest = get_relative_path(Dir.mktmpdir(".gem.", "."))

  t = nil
  Tempfile.open %w"siteconf .rb", "." do |siteconf|
    t = siteconf
    siteconf.puts "require 'rbconfig'"
    siteconf.puts "dest_path = #{tmp_dest.dump}"
    %w[sitearchdir sitelibdir].each do |dir|
      siteconf.puts "RbConfig::MAKEFILE_CONFIG['#{dir}'] = dest_path"
      siteconf.puts "RbConfig::CONFIG['#{dir}'] = dest_path"
    end

    siteconf.flush

    destdir = ENV["DESTDIR"]

    begin
      cmd = [Gem.ruby, "-r", get_relative_path(siteconf.path), File.basename(extension), *args].join ' '

      begin
        run cmd, results
      ensure
        if File.exist? 'mkmf.log'
          results << "To see why this extension failed to compile, please check"                " the mkmf.log which can be found here:\n"
          results << "  " + File.join(dest_path, 'mkmf.log') + "\n"
          FileUtils.mv 'mkmf.log', dest_path
        end
        siteconf.unlink
      end

      ENV["DESTDIR"] = nil

      make dest_path, results

      if tmp_dest
        # TODO remove in RubyGems 3
        if Gem.install_extension_in_lib and lib_dir then
          FileUtils.mkdir_p lib_dir
          entries = Dir.entries(tmp_dest) - %w[. ..]
          entries = entries.map { |entry| File.join tmp_dest, entry }
          FileUtils.cp_r entries, lib_dir, :remove_destination => true
        end

        FileEntry.new(tmp_dest).traverse do |ent|
          destent = ent.class.new(dest_path, ent.rel)
          destent.exist? or FileUtils.mv(ent.path, destent.path)
        end
      end
    ensure
      ENV["DESTDIR"] = destdir
    end
  end
  t.unlink if t and t.path

  results
ensure
  FileUtils.rm_rf tmp_dest if tmp_dest
end
require "mkmf" abort "missing malloc()" unless have_func "malloc" abort "missing free()" unless have_func "free" create_makefile "my_malloc/my_malloc"
#include <ruby.h>

struct my_malloc {
  size_t size;
  void *ptr;
};

static void
my_malloc_free(void *p) {
  struct my_malloc *ptr = p;

  if (ptr->size > 0)
    free(ptr->ptr);
}

static VALUE
my_malloc_alloc(VALUE klass) {
  VALUE obj;
  struct my_malloc *ptr;

  obj = Data_Make_Struct(klass, struct my_malloc, NULL, my_malloc_free, ptr);

  ptr->size = 0;
  ptr->ptr  = NULL;

  return obj;
}

static VALUE
my_malloc_init(VALUE self, VALUE size) {
  struct my_malloc *ptr;
  size_t requested = NUM2SIZET(size);

  if (0 == requested)
    rb_raise(rb_eArgError, "unable to allocate 0 bytes");

  Data_Get_Struct(self, struct my_malloc, ptr);

  ptr->ptr = malloc(requested);

  if (NULL == ptr->ptr)
    rb_raise(rb_eNoMemError, "unable to allocate %ld bytes", requested);

  ptr->size = requested;

  return self;
}

static VALUE
my_malloc_release(VALUE self) {
  struct my_malloc *ptr;

  Data_Get_Struct(self, struct my_malloc, ptr);

  if (0 == ptr->size)
    return self;

  ptr->size = 0;
  free(ptr->ptr);

  return self;
}

void
Init_my_malloc(void) {
  VALUE cMyMalloc;

  cMyMalloc = rb_const_get(rb_cObject, rb_intern("MyMalloc"));

  rb_define_alloc_func(cMyMalloc, my_malloc_alloc);
  rb_define_method(cMyMalloc, "initialize", my_malloc_init, 1);
  rb_define_method(cMyMalloc, "free", my_malloc_release, 0);
}
