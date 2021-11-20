class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :skills
      t.string :salary_range
      t.string :level
      t.datetime :deadline
      t.string :location

      t.timestamps
    end
  end
end
