require 'in_transit'
require 'oystercard'

describe InTransit do
  let(:intransit) { InTransit.new }
  let(:station1) {double(:station)}
  let(:station2) {double(:station)}
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
        intransit.touch_in(station1)
        expect(intransit.in_journey?).to eq(true)
      end

      it 'stores the entry station when touched in' do
        intransit.touch_in(station1)
        expect(intransit.entry_station).to eq station1
      end

      it 'it deactivates the card when touched out' do 
        intransit.touch_in(station1)
        intransit.touch_out(station2)
        expect(intransit.in_journey?).to eq(false)
      end

      it 'deducts min fare on touch out' do 
        intransit.touch_in(station1)
        expect{ intransit.touch_out(station2) }.to change{ intransit.card.balance }.by (-InTransit::MINIMUM_FARE)
      end

      it 'forgets the entry station on touch out' do
        intransit.touch_in(station1)
        intransit.touch_out(station2)
        expect(intransit.entry_station).to eq nil
      end

      it 'stores journey history' do 
        intransit.touch_in(station1)
        intransit.touch_out(station2)
        expect(intransit.journey_history).to eq [ {:entry_station => station1, :exit_station => station2} ]
      end

      it 'empty journey history by default' do 
        expect(intransit.journey_history).to eq []
      end

end

  it 'would raise error if balance is below minimum fare' do 
    expect { intransit.touch_in(station1) }.to raise_error "Insufficient funds: Balance less than #{InTransit::MINIMUM_FARE}"
  end


end 