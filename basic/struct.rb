module FirstLevelModule
  module SecondLevelModule
    Obc = Struct.new(:name)

    class Target

      # 不想用 missing_method, 就用 define_method 來動態定義方法
      Obc.members.each do |col|
        define_method col.to_sym do
          @value.send(col)
        end
      end

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

arr = []
arr << FirstLevelModule::SecondLevelModule::Target.new("test1")
arr << FirstLevelModule::SecondLevelModule::Target.new("test2")

p arr.plcuk(:name)
