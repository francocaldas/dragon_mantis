class AddHeadhunterRefToJob < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :headhunter, null: false, foreign_key: true
  end
end
