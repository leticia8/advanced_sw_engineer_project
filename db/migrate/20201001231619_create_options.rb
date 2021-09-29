class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.string :description
      t.references :proposal, index: true, foreign_key: true

      t.timestamps
    end
  end
end
