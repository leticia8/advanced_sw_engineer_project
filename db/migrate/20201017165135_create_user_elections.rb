class CreateUserElections < ActiveRecord::Migration[6.0]
  def change
    create_table :user_elections do |t|
      t.references :user, index: true, foreign_key: true
      t.references :election, index: true, foreign_key: true

      t.timestamps
    end
  end
end
