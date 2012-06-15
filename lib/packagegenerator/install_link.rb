module PackageGenerator
  class InstallFile < InstallItem
    def initialize(args=nil)
       super args
    end

    def write(output=$stdout)
      validate

      output.write "l #{@mode} #{@user} #{@group} '#{@target}' '#{@source}'\n"
    end

  end
end