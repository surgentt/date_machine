class CreateMessages < ActiveRecord::Migration
  def change 
    create_table :messages do |t|
      t.integer :profile_id
      t.text :message_url
      t.text :message_content
    end
  end
end
