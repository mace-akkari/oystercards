require 'oystercard.rb'

class InTransit
  MINIMUM_FARE = 1
  attr_reader :card

  def initialize
    @activated = false
    @card = Oystercard.new
  end

  def in_journey?
    @activated 
  end

  def touch_in
    #check_balance - oystercard class
    fail "Insufficient funds: Balance less than #{InTransit::MINIMUM_FARE}" if @card.balance < MINIMUM_FARE
    @activated = true
  end 

  def touch_out
    @card.deduct_fare(MINIMUM_FARE)
    @activated = false
  end

end