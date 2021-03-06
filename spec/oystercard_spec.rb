require 'oystercard'

describe Oystercard do

  it "freshly initialized cards should have a balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'can top up the balance' do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end

  it 'raises error if the max-balance is exceeded' do 
    subject.top_up(90)
    expect { subject.top_up 1}.to raise_error "MAX #{Oystercard::MAXIMUM_LIMIT} EXCEEDED"
  end 

  it { is_expected.to respond_to(:deduct_fare).with(1).argument }

  it 'Does deduct fare' do 
    subject.top_up(10)
    expect(subject.deduct_fare(6)).to eq(4)
  end

end 