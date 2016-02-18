class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
