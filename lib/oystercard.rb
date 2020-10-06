class Oystercard
  attr_reader :balance
  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "MAX #{MAXIMUM_LIMIT} EXCEEDED" if exceeded_limit?(money)
    @balance += money
  end 

  private
  def exceeded_limit?(money)
    balance + money > MAXIMUM_LIMIT
  end
end 