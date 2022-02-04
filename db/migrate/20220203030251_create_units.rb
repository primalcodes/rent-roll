class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.integer :unit_number
      t.integer :floor_plan
      t.string :resident
      t.date :move_in
      t.date :move_out

      t.timestamps
    end
  end
end
