class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :description
      t.references :election, index: true, foreign_key: true

      t.timestamps
    end
  end
end
