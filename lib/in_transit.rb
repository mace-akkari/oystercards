require_relative 'oystercard.rb'

class InTransit
  MINIMUM_FARE = 1
  attr_reader :card, :entry_station

  def initialize

    @card = Oystercard.new
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    fail "Insufficient funds: Balance less than #{InTransit::MINIMUM_FARE}" if @card.balance < MINIMUM_FARE
    @entry_station = station
  end 

  def touch_out
    @card.deduct_fare(MINIMUM_FARE)
    @entry_station = nil
  end

end