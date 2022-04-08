module FirstLevelModule
  module SecondLevelModule
    Obc = Struct.new(:name)

    class Target

      attr_accessor :value
      def initialize(data)
        @value = Obc.new(data)
      end
    end
  end
end

t = FirstLevelModule::SecondLevelModule::Target.new("test")
p t.value.name # test
p t.value.members # [:name]