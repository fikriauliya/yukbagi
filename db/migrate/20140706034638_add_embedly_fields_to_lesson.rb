class AddEmbedlyFieldsToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :type, :string
    add_column :lessons, :provider_name, :string
    add_column :lessons, :favicon_url, :string
    add_column :lessons, :description, :string
    add_column :lessons, :thumbnail_url, :string
  end
end
