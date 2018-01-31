describe Journey do
  # entry station at touch in
  # exit station at touch out
  let(:entry_station) { double('entry station') }
  subject(:journey) {described_class.new(entry_station)}

  it "stores the entry station on creation" do
    expect(journey.entry_station).to be
  end


end
