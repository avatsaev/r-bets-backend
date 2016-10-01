class CreateApiApps < ActiveRecord::Migration[5.0]
  def change
    create_table :api_apps do |t|
      t.string :name
      t.integer :access_level, default: 1
      t.string :state

      t.timestamps
    end
  end
end
