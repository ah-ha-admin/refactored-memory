# File lib/rubygems/ext/builder.rb, line 24
def self.class_name
  name =~ /Ext::(.*)Builder/
  $1.downcase
end
