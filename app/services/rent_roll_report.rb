# frozen_string_literal: true

# RentRollReport - Service class to generate a report of the units in the database
class RentRollReport
  def initialize(date: Date.today)
    @date = date
    raise ArgumentError, 'Date must be a Date object' unless date.is_a?(Date)
  end

  def call
    data_rows = report_data

    key_statistics = {
      vacant: Unit.vacant(date).count,
      occupied: Unit.current(date).count,
      leased: Unit.leased(date).count
    }

    formatted_output(data_rows: data_rows, key_statistics: key_statistics)
  end

  private

  attr_reader :date

  def report_data
    report_lines = []
    Unit.all.each do |unit|
      report_lines << [
        unit.unit_number,
        unit.floor_plan,
        unit.resident,
        unit.resident_status_for_date(date: date),
        unit.move_in,
        unit.move_out
      ]
    end
    report_lines
  end
end

def formatted_output(data_rows: [], key_statistics: {})
  output = []
  output << '=' * 80
  output << "Rent Roll Report for #{date}"
  output << '=' * 80

  output << 'Unit Number, Floor Plan, Resident, Resident Status, Move In, Move Out'
  output << '-' * 80
  data_rows.each { |row| output << row.join(', ') }

  output << '=' * 80
  output << "Key Statistics for #{date}"
  output << '=' * 80
  key_statistics.each_key { |key| puts "#{key}: #{key_statistics[key]}" }
  output.join('\n')
end
