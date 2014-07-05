class AddLessonsCountToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :lessons_count, :integer, :default => 0
  end
end
