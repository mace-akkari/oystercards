require 'in_transit'
require 'oystercard'

describe InTransit do
  let(:intransit) { InTransit.new }
  let(:station) {double(:station)}
  describe 'Sufficient funds' do 
    before do 
      intransit.card.top_up(2)
    end
      it 'is not in transit' do
        expect(intransit.in_journey?).to eq(false)
      end

      it { is_expected.to respond_to :touch_in } 

      it { is_expected.to respond_to :touch_out } 

      it 'it activates the card when touched in' do 
        intransit.touch_in(station)
        expect(intransit.in_journey?).to eq(true)
      end

      it 'stores the entry station when touched in' do
        intransit.touch_in(station)
        expect(intransit.entry_station).to eq station
      end

      it 'it deactivates the card when touched out' do 
        intransit.touch_in(station)
        intransit.touch_out
        expect(intransit.in_journey?).to eq(false)
      end

      it 'deducts min fare on touch out' do 
        intransit.touch_in(station)
        expect{ intransit.touch_out }.to change{ intransit.card.balance }.by (-InTransit::MINIMUM_FARE)
      end

      it 'forgets the entry station on touch out' do
        intransit.touch_in(station)
        intransit.touch_out
        expect(intransit.entry_station).to eq nil
      end
end

  it 'would raise error if balance is below minimum fare' do 
    expect { intransit.touch_in(station) }.to raise_error "Insufficient funds: Balance less than #{InTransit::MINIMUM_FARE}"
  end


end 