# frozen_string_literal: true

require 'csv'
# RentRollImport - Service class to import RentRoll data into the database
class RentRollImport
  # Import the given CSV file into the database
  # @param [String] file_path - the path to the CSV file
  # @return [Boolean] - true if the import was successful, false otherwise

  class RentRollImportError < StandardError; end

  def initialize(file_path:)
    @file_path = file_path
  end

  def call
    raise FileNotFound, "File #{path} not found" unless File.exist?(file_path)

    import_file
  end

  private

  attr_reader :file_path

  def import_file
    successful = false
    err_message = nil 
    ActiveRecord::Base.transaction do
      CSV.foreach(file_path, headers: true) do |row|
        Unit.create!(
          unit_number: row['unit'],
          floor_plan: row['floor_plan'],
          resident: row['resident'],
          move_in: parse_date(row['move_in']),
          move_out: parse_date(row['move_out'])
        )
      end
      successful = true
    rescue ActiveRecord::RecordInvalid => e
      err_message = e.message
      raise ActiveRecord::Rollback
    end
    return true if successful

    raise RentRollImportError, err_message
  end

  def parse_date(date_str)
    return nil if date_str.blank?

    Date.strptime(date_str, '%m/%d/%Y')
  end
end
