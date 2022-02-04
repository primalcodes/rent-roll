class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.integer :unit_number, null: false
      t.integer :floor_plan, null: false
      t.string :resident
      t.date :move_in
      t.date :move_out

      t.timestamps
    end
  end
end
