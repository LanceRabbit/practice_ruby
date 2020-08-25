# problem: while add singleton method, call cinit_events again,
# the callbacks will add same callback into list on add_listener method.
# root casuse: singleton_class

class EventManager
  def initialize
    @callbacks = []
  end

  def add_listener(callback)
    return if @callbacks.include?(callback)
    p callback
    @callbacks << callback
    p @callbacks
  end
end

class Player
  def initialize
    @hp = 100
    @em = EventManager.new
  end

  def init_events
    @em.add_listener(method(:hp_changed))
  end

  def hp=(new)
    @hp = new
  end

  def equip(weapon)
    # instance_eval('undef :attack')
    define_singleton_method :attack do
      puts "Attack with #{weapon}"
    end

    # 這邊 self 宣告的方法也會放在 singleton_methods 內
    # def self.attack
    #   puts "Attack with #{weapon}"
    # end
  end

  def atack
    puts "Attack with Hand"
  end

  def hp_changed
    puts 'Changed'
  end
end

# 動態定義方法會存放在 singleton_class 內
# 因此,

player = Player.new
p "11111-new: #{player}"

# 第一種解法: 直接初始化 singleton_class.
# player.singleton_class

player.init_events
p "22222-init_events: #{player}"

player.hp = 90
# => Changed

p "33333-hp: #{player}"
p "33333-hp: #{player.singleton_class.ancestors}"

p "33333-singleton_methods: #{player.singleton_methods}"

player.equip('Sword')

p "44444-equip: #{player}"
p "44444-equip: #{player.singleton_class.ancestors}"
p "44444-singleton_methods: #{player.singleton_methods}"

player.init_events

p "55555-init_events: #{player}"

player.hp = 80

p "66666-hp: #{player}"

# => Changed
# => Changed