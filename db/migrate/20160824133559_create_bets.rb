class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.string :title
      t.integer :answer_a_count, default: 0
      t.integer :answer_b_count, default: 0
      t.string :answer_a
      t.string :answer_b
      t.datetime :ends_at
      t.string :state

      t.timestamps
    end
  end
end
