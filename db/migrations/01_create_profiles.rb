class CreateProfiles < ActiveRecord::Migration
  def change 
    create_table :profiles do |t|
      t.string :username
      t.integer :messaged
      t.integer :match_score
    end
  end
end
