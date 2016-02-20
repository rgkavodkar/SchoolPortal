class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :user, index: true, foreign_key: true
      t.text :status

      t.timestamps null: false
    end
  end
end
