RentRollImport.new(file_path: File.join(Rails.root, 'db/rent_roll.csv')).call
RentRollReport.new(date: Date.today).call
