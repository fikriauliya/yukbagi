class AddExternalUrlHtmlToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :external_url_html, :string
  end
end
