require 'station'

describe Station do
  let(:station) {Station.new('Leicester Square',1)}
  it 'can store and recall its name' do
    expect(station.name).to eq 'Leicester Square'
  end

  it 'can store and recall its zone' do
    expect(station.zone).to eq 1
  end
end