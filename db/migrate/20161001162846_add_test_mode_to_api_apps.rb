class AddTestModeToApiApps < ActiveRecord::Migration[5.0]
  def change
    add_column :api_apps, :test_mode, :boolean, default: false
  end
end
