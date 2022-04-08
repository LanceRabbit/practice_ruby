class Account

  attr_reader :status, :message

  def initialize(*arg)
  end

  def call
    set_response('hello ruby',400)

    # itself == self
    itself
  end

  private

  def set_response(resp_message, status_code)
    @message = resp_message
    @status = status_code
  end
end

result =  Account.new.call

p result.message