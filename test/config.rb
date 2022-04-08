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

# p Test::Config.setting.object_id
# p Test::Config.setting.object_id
# p Test::Config.setting.object_id

module Service
  module Config
    extend self

    attr_accessor :api_key, :test

    def configure
      yield self
    end
  end
end

Service::Config.configure do |config|
  config.api_key = "1234"
  config.test = "test"
end

p Service::Config.api_key
p Service::Config.test

# 做法等同 Service::Config
module ServiceNormal
  module Config
    class << self
      attr_accessor :api_key, :test

      def configure
        yield self
      end
    end
  end
end

ServiceNormal::Config.configure do |config|
  config.api_key="ABCD"
  config.test="heeee"
end

p ServiceNormal::Config.api_key
p ServiceNormal::Config.test