class RenameUrlIntoExternalUrlOnLesson < ActiveRecord::Migration
  def change
    rename_column :lessons, :url, :external_url
  end
end
