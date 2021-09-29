class AddColumnActivatedToElections < ActiveRecord::Migration[6.0]
  def change
    add_column :elections, :activated, :boolean
  end
end
