class InTransit

  def initialize
    @activated = false
  end

  def in_journey?
    @activated 
  end

  def touch_in
    @activated = true
  end 

  def touch_out
    @activated = false
  end

end