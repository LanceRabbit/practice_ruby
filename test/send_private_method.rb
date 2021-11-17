class SendPrivateMethod
  def initialize(**params)
    @params = params
  end

  def call
    SendPrivateMethod.private_instance_methods(false)
    .select do |method| method.to_s.include?('check') end
    .each do |method|
      send(method)
    end
  end

  private

  attr_accessor :params

  def check_method_1
    p "private method 1 #{params[:key]}"
  end

  def check_method_2
    p "private method 2 #{params[:obj]}"
  end
end

SendPrivateMethod.new(key: 123, obj: 'object--').call