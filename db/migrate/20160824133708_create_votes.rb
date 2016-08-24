class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :username
      t.string :ip_addr
      t.string :answer
      t.integer :bet_id

      t.timestamps
    end


  end
end
