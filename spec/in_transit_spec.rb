require 'in_transit'
require 'oystercard'

describe InTransit do
  describe 'Sufficient funds' do 
    before do 
      allow_any_instance_of(Oystercard).to receive(:balance).and_return(2)
    end
      it 'is not in transit' do
        expect(subject.in_journey?).to eq(false)
      end

      it { is_expected.to respond_to :touch_in } 

      it { is_expected.to respond_to :touch_out } 

      it 'it activates the card when touched in' do 
        subject.touch_in
        expect(subject.in_journey?).to eq(true)
      end

      it 'it deactivates the card when touched out' do 
        subject.touch_in
        subject.touch_out
        expect(subject.in_journey?).to eq(false)
      end
end

  it 'would raise error if balance is below minimum fare' do 
    expect { subject.touch_in }.to raise_error "Insufficient funds: Balance less than #{InTransit::MINIMUM_FARE}"
  end


end 