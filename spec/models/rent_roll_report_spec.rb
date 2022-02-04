require 'rails_helper'

RSpec.describe RentRollReport do
  describe '#initialize' do
    it 'should raise exception when date is invalid' do
      expect do
        RentRollReport.new(date: '12/12/22')
      end.to raise_exception
    end
  end

  describe '#call' do
    let(:file_path) { 'spec/fixtures/rent_roll_import.csv' }

    it 'should return a String on success' do
      RentRollImport.new(file_path: file_path).call
      output = RentRollReport.new(date: Date.parse('2020-12-01')).call
      expect(output).to be_a(String)
    end
  end
end
