class CreateAppTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :app_tokens do |t|
      t.integer :api_app_id
      t.string :secret
      t.string :access_token
      t.string :state

      t.timestamps
    end
  end
end
