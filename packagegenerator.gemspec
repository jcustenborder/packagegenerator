Gem::Specification.new do |s|
  s.name        = 'packagegenerator'
  s.version     = '0.0.1'
  s.date        = '2012-06-15'
  s.summary     = "packagegenerator is a simple wrapper to generate input files for epm."
  s.description = "packagegenerator is a simple wrapper to generate input files for epm."
  s.authors     = ["Jeremy Custenborder"]
  s.email       = 'jcustenborder@gmail.com'
  s.files       = ['lib/packagegenerator/generator.rb',
      'lib/packagegenerator/install_config.rb',
      'lib/packagegenerator/install_directory.rb',
      'lib/packagegenerator/install_file.rb',
      'lib/packagegenerator/install_item.rb',
      'lib/packagegenerator/install_link.rb',
      'lib/packagegenerator.rb']
  s.test_files  = ['test/test_generator.rb']
  s.homepage    =
    'http://github.com/jcustenborder/packagegenerator'
end