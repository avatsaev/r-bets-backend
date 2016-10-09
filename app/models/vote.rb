class Vote < ApplicationRecord
  belongs_to :bet
  validates :username, length: { in: 2..80 }, allow_blank: false
  validates :username, format: { without: /\s/ }

  validates :answer, presence: true

  #validates :ip_addr, uniqueness: { scope: [:bet_id, :answer], message: "You've already voted on this bet" }

  #validates :username, uniqueness: { scope: [:bet_id, :answer], message: "This username already voted on this bet" }

  #after_commit
  #after_commit :broadcast_vote


  after_commit :register_vote, on: :create

  def as_json(opts={})
    json = {}

    json = json.merge({
      id: id,
      username: username,
      answer: answer,
      created_at: created_at
    })

    json

  end



    # def broadcast_vote
    #   BroadcastVoteJob.perform_later(self)
    # end

  def register_vote
    self.increment_bet_vote_count
    BroadcastVoteJob.perform_later(self)

  end

    def increment_bet_vote_count

      if self.answer == "a"
        self.bet.increment(:answer_a_count).save
      elsif  self.answer == "b"
        self.bet.increment(:answer_b_count).save
      end
    end

end
