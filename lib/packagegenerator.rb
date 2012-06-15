require File.join(File.dirname(__FILE__), 'packagegenerator', 'generator')
require File.join(File.dirname(__FILE__), 'packagegenerator', 'install_item')
require File.join(File.dirname(__FILE__), 'packagegenerator', 'install_file')
require File.join(File.dirname(__FILE__), 'packagegenerator', 'install_directory')

module PackageGenerator
  unless const_defined?(:VERSION)
    VERSION = '0.0.1'
  end
end