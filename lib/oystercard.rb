require_relative 'station'

class Oystercard

  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  DEFAULT_LIMIT = 90
  attr_reader :balance, :entry_station, :exit_station, :journey_history, :current_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    # raise "you didn't touch out" if @exit_station == nil
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @exit_station = station
    save_journey
    reset_stations
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def save_journey
    @journey_history << {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  def reset_stations
    @entry_station = nil
  end
end
