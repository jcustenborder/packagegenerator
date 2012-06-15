module PackageGenerator
  class InstallConfig < InstallItem
    def initialize(args=nil)
       super args
    end

    def write(output=$stdout)
      validate

      output.write "c #{@mode} #{@user} #{@group} '#{@target}' '#{@source}'\n"
    end

  end
end