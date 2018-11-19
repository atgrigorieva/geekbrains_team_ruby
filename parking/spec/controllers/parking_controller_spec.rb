require 'rails_helper'

RSpec.describe ParkingController, type: :controller do
  describe "action free_place" do
    context "when user as operator" do
      
      it 'should return free place' do
        resp = post :free_place
        puts resp
      end

      it 'should\'t return free place' do

      end

    end
    context "when user as owner" do
      it 'does something' do
        puts 'somthing'
      end
    end
  end
  
  
end
