class AddVotesCountToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :votes_count, :integer
  end
end
