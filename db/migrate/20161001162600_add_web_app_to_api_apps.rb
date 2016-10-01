class AddWebAppToApiApps < ActiveRecord::Migration[5.0]
  def change
    add_column :api_apps, :web_app, :boolean
  end
end
