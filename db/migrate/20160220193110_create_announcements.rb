class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :content
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
