require 'pathname'

module PackageGenerator
  class Generator

    attr_writer :package_name, :copyright, :description, :version, :vendor, :license, :readme, :preinstall_commands, :postinstall_commands, :install_items

    def initialize
      @license = 'LICENSE'
      @readme = 'README'
      @install_items = []
    end

    def add_install_item(item)
      @install_items << item
    end

    def add_directory_contents(target_path, directory_path, exclude=[])
       directory_search=File.join(directory_path, '**', '*')
       directory_pathname=Pathname.new(directory_path)

       search_files = Dir.glob(directory_search)

       exclude.each do |excluded_item|
         search_files.delete excluded_item
       end


       search_files.each do |file_name|
        if File.file?(file_name)
          install_file = PackageGenerator::InstallFile.new
          install_file.source = file_name
          install_file.mode = Integer("%o" % (File.lstat(file_name).mode & 0777))

          file_pathname = Pathname.new(file_name)
          relative_path = file_pathname.relative_path_from(directory_pathname)

          install_file.target = File.join(target_path, relative_path)

          add_install_item install_file
        end
      end
    end


    def generate(output=$stdout)
      raise ArgumentError, 'package_name cannot be nil.' if @package_name.nil?
      raise ArgumentError, 'copyright cannot be nil.' if @copyright.nil?
      raise ArgumentError, 'vendor cannot be nil.' if @vendor.nil?
      raise ArgumentError, 'license cannot be nil.' if @license.nil?
      raise ArgumentError, 'readme cannot be nil.' if @readme.nil?
      raise ArgumentError, 'description cannot be nil.' if @description.nil?
      raise ArgumentError, 'version cannot be nil.' if @version.nil?

      output.write "%product #{@package_name}\n"
      output.write "%copyright #{@copyright}\n"
      output.write "%vendor #{@vendor}\n"
      output.write "%license #{@license}\n"
      output.write "%readme #{@readme}\n"
      output.write "%description #{@description}\n"
      output.write "%version #{@version}\n"

      write_preinstall(output) if @preinstall_commands.is_a?(Array)
      write_postinstall(output) if @postinstall_commands.is_a?(Array)
      write_install_items(output) if @install_items.is_a?(Array) && @install_items.length > 0
    end

    :private
    def write_preinstall(output)
      output.write "\n"
      preinstall_index = 0
      @preinstall_commands.each do |preinstall_command|
        output.write "%preinstall "
        if preinstall_command =~ /\n/
          output.write "<< EOF#{preinstall_index}\n"
          output.write "#{preinstall_command}\n"
          output.write "EOF#{preinstall_index}\n"
        else
          output.write "#{preinstall_command}\n"
        end

        preinstall_index += 1
      end
    end

    def write_postinstall(output)
      output.write "\n"
      postinstall_index = 0
      @postinstall_commands.each do |postinstall_command|
        output.write "%postinstall "
        if postinstall_command =~ /\n/
          output.write "<< EOF#{postinstall_index}\n"
          output.write "#{postinstall_command}\n"
          output.write "EOF#{postinstall_index}\n"
        else
          output.write "#{postinstall_command}\n"
        end

        postinstall_index += 1
      end
    end

    def write_install_items(output)
      output.write "\n"
      @install_items.each do |install_file|
        if(install_file.is_a?(InstallItem))
          install_file.write(output)
        end
      end
    end

  end

end
