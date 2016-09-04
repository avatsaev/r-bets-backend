# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class BetChannel < ApplicationCable::Channel

  def subscribed
    stream_from "bet_channel_#{params[:bet_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end


  def place_vote(data)

    if data['bet_id'] and data['answer'] and data['username']

      bet = Bet.find(data['bet_id'])
      vote = bet.votes.new(answer: data['answer'], username: data['username'])


      if (vote.valid?)
        vote.save!
        broadcast("bet_channel_#{params[:bet_id]}", {event: 'new_vote', bet: bet, vote: vote})
      end

    end

  end

  private

    def broadcast(event, data)
      ActionCable.server.broadcast event, data
    end

end
