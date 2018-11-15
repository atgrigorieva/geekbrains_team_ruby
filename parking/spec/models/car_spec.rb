require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:number) {"Y123ZI"}
  let(:region) {38}
  let(:driver_name) {"Ivanov Ivan Mihailovich"}
  context "validation car" do
    it 'ensures number is present' do
      car = Car.new(:number => number)
      expect(car.valid?).to eq(false)
    end
    it 'ensures region is present' do
      car = Car.new(:region => 38)
      expect(car.valid?).to eq(false)
    end
    it 'ensures driver is present' do
      car = Car.new(:driver_name => driver_name)
      expect(car.valid?).to eq(false)
    end
    it 'should be able to save car' do
      car = Car.new(:driver_name => driver_name, :number => number, region: region)
      expect(car.save).to eq(true)
    end
  end
end
