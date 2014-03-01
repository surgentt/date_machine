class CreateMessages < ActiveRecord::Migration
  def change 
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      # t.integer :conversation_id
      # t.string :message_url
      t.text :message_content
    end
  end
end
