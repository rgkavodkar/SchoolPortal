class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps null: false
    end
  end
end
