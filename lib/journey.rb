class Journey

  PENALTY_FARE = 6
  BASE_FARE = 1

  attr_accessor :exit_station, :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    if incomplete_journey?
      PENALTY_FARE
    else
      BASE_FARE
    end
  end

  def incomplete_journey?
    return true if @entry_station == nil && @exit_station != nil
    return true if @entry_station != nil && @exit_station == nil
    false
  end

end
