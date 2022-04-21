class CreateDevelopers < ActiveRecord::Migration[7.0]
  def change
    create_table :developers do |t|
      t.string :name, null: false
      t.integer :age, null: false

      t.timestamps
    end
  end
end
