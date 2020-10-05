require 'oystercard'

describe Oystercard do
  describe "initialized cards" do
    it "freshly initialized cards should have a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end


end