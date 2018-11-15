require 'rails_helper'

RSpec.describe CarController, type: :controller do

  describe "entry or leave in parking" do
    let(:true_parameters_entry) { {:params => {:action => true,:car_number => { number: "FAD83438"}}}}
    let(:true_parameters_leave) { {:params => {:action => false,:car_number => { number: "DER83438"}}}}
    let(:false_parameters_entry) { {:params => {:action => true,:car_number => { number: "АВЕ38438"}}}}
    let(:false_parameters_leave) { {:params => {:action => false,:car_number => { number: "ЯХУ38438"}}}}
    let(:true_parameters_car) {{:params => {
      car_setting: {
        number:"DIZ38438",
        driver_name:"Михаил Иванович Печка"},
      reservation: {
        rate: "Помесячная",
        parking_place: 1}
    }}}

    before do
      op = create(:operator_role)
      ow = create(:owner_role)
      
      owner_user = User.create! attributes_for(:owner_user).merge({role: ow})
      
      @owner = Owner.create! :id => 9001, :user => owner_user, :first_name => "Владимир", :last_name => "Путин", :second_name => "Владимирович"
      
      parking = create(:parking, owner: @owner)
      
      operator_user = User.create! attributes_for(:operator_user).merge({role: op})
      @operator = Operator.create! :id => 9000, :user => operator_user, :parking => parking, :name => "Иван Иванович"
      create(:month_rate, :id => 1, :parking => parking)
      create(:car_first, :id => 1)
      create(:free_place, parking: parking)
      sign_in operator_user
    end

    context "when number is incorrect" do
      
      it "should return error when car entry" do
        resp = patch :entry_or_leave, false_parameters_entry
        expect(JSON.parse(resp.body).has_key? "error").to eq(true)
      end

      it "should be return error when car leave" do
        resp = patch :entry_or_leave, false_parameters_leave
        expect(JSON.parse(resp.body).has_key? "error").to eq(true)
      end
    end
    
    context "when database not found car number" do

      it 'should return false when car entry' do
        resp = patch :entry_or_leave, true_parameters_entry 
        expect(JSON.parse(resp.body)["found"]). to eq(false)
      end

      it 'should return false when car leave' do
        resp = patch :entry_or_leave, true_parameters_leave 
        expect(JSON.parse(resp.body)["found"]). to eq(false)
      end



    end


    context 'when car creating' do

      it 'should return error false' do
        resp = patch :create, true_parameters_car
        expect(JSON.parse(resp.body)["error"]).to eq(false)
      end

      it 'reservation must exist when car created' do
        patch :create, true_parameters_car
        number = true_parameters_car[:params][:car_setting][:number].scan(/((.){6})/)[0][0]
        region = true_parameters_car[:params][:car_setting][:number].gsub(/((.){6})/, '')
        car = Car.find_by(:number => number, :region => region)
        # отбираем по всем броням только не закрытые
        reserv_not_payed = HistoryReservation.all.where(:car => car, :date_out => nil)
        expect(reserv_not_payed.nil?).to eq(false)
      end

      it 'place must busy when reserved' do
        patch :create, true_parameters_car
        place = true_parameters_car[:params][:reservation][:parking_place]
        place = @operator.parking.parking_places.find_by(number: place)
        expect(place.busy).to eq(true)
      end
    
    end

    context 'when database know car number' do
      
      it 'should be return found true when car entry' do
        car = Car.first
        resp = patch :entry_or_leave, {params: {
          action: true,
          car_number: {number: "#{car.number}#{car.region}" }}}
        expect(JSON.parse(resp.body)["found"]).to eq(true)
      end

      it 'should be return found true when car leave' do
        car = Car.first
        resp = patch :entry_or_leave, {params: {
          action: false,
          car_number: {number: "#{car.number}#{car.region}" }}}
        expect(JSON.parse(resp.body)["found"]).to eq(true)
      end

      it 'should be return rates when car entry and place not reserved' do
        car = Car.first
        resp = patch :entry_or_leave, {params: {
          action: true,
          car_number: {number: "#{car.number}#{car.region}" }}}
        p resp.body
        expect(JSON.parse(resp.body)["rates"].nil?).to eq(false)
      end


    end
  end
  
end
