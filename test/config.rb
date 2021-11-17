module Test
  class Config
    class << self
      def setting
        p 'run setting'
        return @setting if @setting

        p 'setup setting'
        @setting ||= 'first time'
      end
    end
  end
end

p Test::Config.setting.object_id
p Test::Config.setting.object_id
p Test::Config.setting.object_id