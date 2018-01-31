class Journey

  PENALTY_FARE = 6
  BASE_FARE = 1

  attr_accessor :exit_station, :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    if @entry_station == nil && @exit_station != nil
      PENALTY_CHARGE
    elsif @entry_station != nil && @exit_station == nil
      PENALTY_CHARGE
    else
      MINIMUM_BALANCE
    end
  end


   # The fare method should return the correct fare,
   # or the penalty fare of 6 if there was either no entry
   # station or no exit_station.
end
