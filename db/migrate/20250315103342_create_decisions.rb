class CreateDecisions < ActiveRecord::Migration[8.0]
  def change
    create_table :decisions do |t|
      t.string :chapter
      t.string :name
      t.integer :date
      t.text :summary

      t.timestamps
    end
  end
end
