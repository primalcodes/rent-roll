# frozen_string_literal: true

namespace :reports do
  desc 'RentRollReport - generate a report of the units in the database'
  task :rent_roll, [:for_date] => :environment do |_t, args|
    date = args[:for_date] || Date.today
    if date.is_a?(String)
      # Accept '2022-02-02' format
      date = Date.parse(date) if date.match?(/\d{4}-\d{2}-\d{2}/)

      # Accept '02/02/2022' format
      date = Date.strptime(date, '%m/%d/%Y') if date.match?(/\d{2}\/\d{2}\/\d{4}/)
    end

    RentRollReport.new(date: date).call
  end
end
