require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe 'creation' do
    before(:each) do
      @unit = FactoryBot.build(:unit)
    end

    it 'can be created' do
      @unit.save
      expect(@unit).to be_valid
    end

    it 'cannot be created without a unit_number' do
      @unit.unit_number = nil
      expect(@unit).to_not be_valid
    end

    it 'cannot be created without floor_plan' do
      @unit.floor_plan = nil
      expect(@unit).to_not be_valid
    end

    it 'should be able to scope vacant when no dates are present' do
      @unit.move_in = nil
      @unit.move_out = nil
      @unit.save
      expect(Unit.vacant(Date.today).count).to eq(1)
    end

    it 'should be able to scope vacant with past move_out date' do
      @unit.move_in = Date.today - 1.week
      @unit.move_out = Date.today - 1.day
      @unit.save
      expect(Unit.vacant(Date.today).count).to eq(1)
    end

    it 'should be able to scope future with future move_in date and nil move_out date' do
      @unit.move_in = Date.today + 1.week
      @unit.move_out = nil
      @unit.save
      expect(Unit.future(Date.today).count).to eq(1)
    end

    it 'should be able to scope current when move_in date is in the past and move_out date is nil' do
      @unit.move_in = Date.today - 1.week
      @unit.move_out = nil
      @unit.save
      expect(Unit.current(Date.today).count).to eq(1)
    end

    it 'should be able to scope current when move_in date is in the past and move_out date is >= given date' do
      @unit.move_in = Date.today - 1.week
      @unit.move_out = Date.today + 1.week
      @unit.save
      expect(Unit.current(Date.today).count).to eq(1)
    end
  end
end
