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

# p Service::Config.api_key # "1234"
# p Service::Config.test # "test"

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

# p ServiceNormal::Config.api_key
# p ServiceNormal::Config.test


module ServiceModule
  module Config

    module_function

    def configure
      yield self
    end

    def api_key=(api_key)
      @api_key = api_key
    end

    def api_key
      @api_key
    end

    def test=(test)
      @test = test
    end

    def test
      @test
    end
  end
end


ServiceModule::Config.configure do |config|
  config.api_key="ABCD"
  config.test="heeee"
end

# p ServiceModule::Config.api_key
# p ServiceModule::Config.test

# 檢查設定參數是否有值, 測試
# REF: https://github.com/feministy/lizabinante.com/blob/stable/source/2016-03-31-configurable-ruby-gems-custom-errors-and-testing.markdown
# https://github.com/feministy/lizabinante.com/blob/stable/source/2016-01-30-creating-a-configurable-ruby-gem.markdown
# https://brandonhilkert.com/blog/ruby-gem-configuration-patterns/
# https://www.skcript.com/svr/the-easiest-configuration-block-for-your-ruby-gems/
# https://blog.toshimaru.net/ruby-configuration-pattern/
# https://thoughtbot.com/blog/mygem-configure-block
module ConfigPatten
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  class Configuration
    attr_accessor :api_key, :test
  end
end


ConfigPatten.configure do |config|
  config.api_key="ConfigPatten"
  config.test="ConfigPatten--test"
end

p ConfigPatten.configuration.api_key
p ConfigPatten.configuration.test


# REF: https://medium.com/@vfreefly/the-most-simple-configuration-block-implementation-for-a-ruby-gem-815fe1dad5dc

require 'ostruct'
module ConfigOpenStruct
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= OpenStruct.new
    end
  end
end

ConfigOpenStruct.configure do |config|
  config.api_key="ConfigOpenStruct"
  config.test="ConfigOpenStruct--test"
end

p ConfigOpenStruct.configuration.api_key
p ConfigOpenStruct.configuration.test



# frozen_string_literal: true

module Brightcove
  module Base
    class << self
      def configure
        yield(configuration)
      end

      def configuration
        @configuration ||= Configuration.new
      end
    end
    class Configuration
      attr_accessor :client_id, :client_secret, :account_id
    end
  end
end

Brightcove::Base.configure do |config|
  config.client_id="Brightcove::Base--client_id"
  config.client_secret="Brightcove::Base--client_secret"
  config.account_id="Brightcove::Base--account_id"
end

p Brightcove::Base.configuration.client_id
p Brightcove::Base.configuration.client_secret
p Brightcove::Base.configuration.account_id



require 'forwardable'

module Brightcove
  module Base
    module Errors
      class Configuration < StandardError; end
    end
    class Config
      class << self
        extend Forwardable
        # below is rails version
        # delegate :client_id, :client_secret, :account_id, to: :configuration
        def_delegators :@configuration, :client_id, :client_secret, :account_id

        def configure
          yield(configuration)
        end

        def configuration
          @configuration ||= new
        end
      end

      attr_writer :client_id, :client_secret, :account_id

      def initialize
        @client_id = nil
        @client_secret = nil
        @account_id = nil
      end

      def client_id
        raise Errors::Configuration, "client_id is nil" unless @client_id

        @client_id
      end

      def client_secret
        raise Errors::Configuration, "client_secret is nil" unless @client_secret

        @client_secret
      end

      def account_id
        raise Errors::Configuration, "account_id is nil" unless @account_id

        @account_id
      end
    end
  end
end


# Brightcove::Base::Config.configure do |config|
#   config.client_id="Brightcove::Base::Config--client_id"
#   config.client_secret="Brightcove::Base::Config--client_secret"
#   config.account_id="Brightcove::Base::Config--account_id"
# end

Brightcove::Base::Config.configure do |config|
  config.client_id=nil
end

p Brightcove::Base::Config.client_id
p Brightcove::Base::Config.client_secret
p Brightcove::Base::Config.account_id