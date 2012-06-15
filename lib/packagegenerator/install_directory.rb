module PackageGenerator
  class InstallDirectory < InstallItem
    def initialize(args=nil)
       super args
    end

    def write(output=$stdout)
      validate

      output.write "d #{@mode} #{@user} #{@group} '#{@target}' -\n"
    end

  end
end