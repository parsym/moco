class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.integer :number, limit: 5 # calculation: [log with base 2 (9999999999) + 1] is the number of bits required to store the number 10*9 , 1 byte = 8 bits

      t.timestamps null: false
    end
  end
end
