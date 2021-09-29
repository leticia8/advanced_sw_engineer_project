class CreateElections < ActiveRecord::Migration[6.0]
  def change
    create_table :elections do |t|
      t.string :description
      t.datetime :start_date
      t.datetime :finish_date
      t.references :user, index: true, foreign_key: true
      t.integer :segmented_by
      t.string :condition

      t.timestamps
    end
  end
end
