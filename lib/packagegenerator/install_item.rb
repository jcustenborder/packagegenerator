module PackageGenerator
  class InstallItem
    attr_writer :mode, :user, :group, :source, :target

    def initialize args
      unless args.nil?
        @mode = args[:mode] if args.has_key?(:mode)
        @group = args[:group] if args.has_key?(:group)
        @user = args[:user] if args.has_key?(:user)
        @source = args[:source] if args.has_key?(:source)
        @target = args[:target] if args.has_key?(:target)
      else
        @mode = 644
        @user = 'root'
        @group ='root'
      end
    end

    :protected
    def validate
      raise ArgumentError, 'mode must be an number.' unless @mode.is_a?(Numeric)
      raise ArgumentError, 'user cannot be nil.' if @user.nil?
      raise ArgumentError, 'group cannot be nil.' if @group.nil?
      raise ArgumentError, 'source cannot be nil.' if @source.nil?
      raise ArgumentError, 'target cannot be nil.' if @target.nil?
    end

  end
end