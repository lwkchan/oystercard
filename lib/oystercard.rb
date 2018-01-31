require_relative 'station'
require_relative 'journey'


class Oystercard

  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  DEFAULT_LIMIT = 90
  PENALTY_CHARGE = 6
  attr_reader :balance, :journey_history, :current_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
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
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
    # need to charge for a journey where the person has touched in twice
    if @current_journey != nil && @current_journey.entry_station != nil
      deduct(fare)
      save_journey
    end
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey = Journey.new(nil) if @current_journey.entry_station == nil
    @current_journey.exit_station = station
    deduct(fare)
    save_journey
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end
  #
  # def fare -- ported to Journey class
  #   if @current_journey.entry_station == nil && @current_journey.exit_station != nil
  #     PENALTY_CHARGE
  #   elsif @current_journey.entry_station != nil && @current_journey.exit_station == nil
  #     PENALTY_CHARGE
  #   else
  #     MINIMUM_BALANCE
  #   end
  # end

  def save_journey
    @journey_history << @current_journey
  end

end
