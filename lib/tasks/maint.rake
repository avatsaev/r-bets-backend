namespace :maint do
  desc "update vote counter vote bets"
  task :votes_counter => :environment do
    Bet.all.each do |b|
      b.update_attributes(:votes_count => b.votes.count)
    end
  end

end