class BroadcastVoteJob < ApplicationJob
  queue_as :default

  def perform(vote)
    ActionCable.server.broadcast("bet_channel_#{vote.bet.id}", {event: 'new_vote',bet: vote.bet, vote: vote})
  end
end
