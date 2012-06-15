require "test/unit"
require 'packagegenerator'
require 'tmpdir'

class Generator < Test::Unit::TestCase
  def tempfolder
     return File.join(Dir.tmpdir(), 'packagegenerator')
  end

  def setup
    500.times do |i|
      directory_number = i%7
      directory_path = File.join(tempfolder, directory_number.to_s)
      FileUtils.makedirs directory_path unless Dir.exists?(directory_path)

      file_path = File.join(directory_path, i.to_s)

      File.open file_path, 'w' do |f|
        f.write i
      end

      File.chmod 0755, file_path if i % 3 == 1
      File.chmod 0700, file_path if i % 4 == 1
      File.chmod 0600, file_path if i % 2 == 1
    end
  end

  def teardown
    FileUtils.rmtree tempfolder
  end

  def test_something
    foo = PackageGenerator::Generator.new
    foo.package_name= 'example_package'
    foo.copyright= 'Copyright some company 2012'
    foo.vendor='some company'
    foo.description='adsfasd'
    foo.version = '1.0.0.0'
    #foo.preinstall_commands=['echo preinstall "#1"', "echo 'multiline'\necho 'test'"]
    #foo.postinstall_commands=['echo preinstall "#1"', "echo 'multiline'\necho 'test'"]

    foo.add_directory_contents '/var/lib/test/packagegenerator', tempfolder
    foo.generate
  end

end