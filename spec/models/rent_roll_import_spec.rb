require 'rails_helper'

RSpec.describe RentRollImport do
  describe '#call' do
    let(:file_path) { 'spec/fixtures/rent_roll_import.csv' }
    let(:invalid_file_path) { 'spec/fixtures/invalid_rent_roll_import.csv' }

    it 'should return true on successful run' do
      expect(RentRollImport.new(file_path: file_path).call).to eq(true)
    end

    it 'should raise exception when file does not exist' do
      expect do
        RentRollImport.new(file_path: "#{file_path}abc").call
      end.to raise_exception
    end

    it 'should not import any of the unit records if one fails' do
      before_total_unit_count = Unit.count
      begin
        RentRollImport.new(file_path: invalid_file_path).call
      rescue
        # do nothing
      end
      expect(Unit.count).to eq(before_total_unit_count)
    end

    it 'should raise FileNRentRollImportError when file import fails' do
      expect do
        RentRollImport.new(file_path: invalid_file_path).call
      end.to raise_error(RentRollImport::RentRollImportError)
    end
  end
end
