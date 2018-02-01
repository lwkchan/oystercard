require 'journey'

describe Journey do

  subject(:journey) {described_class.new(:entry_station)}

  it "stores the entry station on creation" do
    expect(journey.entry_station).to be :entry_station
  end

  describe "#fare" do

    it "returns the penalty charge for an incomplete journey" do
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

    it "returns the minimum charge for a complete journey" do
      exit_station = double('exit_station')
      subject.exit_station = exit_station
      expect(subject.fare).to eq(Journey::BASE_FARE)
    end

  end

end
