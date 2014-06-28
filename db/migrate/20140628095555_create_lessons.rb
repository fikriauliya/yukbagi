class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :summary
      t.integer :group_id
      t.integer :order_no

      t.timestamps
    end
  end
end
