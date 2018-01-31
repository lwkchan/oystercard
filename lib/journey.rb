class Journey

  attr_writer :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end
end
