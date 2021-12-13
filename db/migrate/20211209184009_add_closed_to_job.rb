class AddClosedToJob < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :closed, :boolean
  end
end
