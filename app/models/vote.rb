class Vote < ApplicationRecord
  belongs_to :bet
  validates :username, length: { in: 2..80 }, allow_blank: false
  validates :username, format: { without: /\s/ }

  validates :answer, presence: true

  #validates :ip_addr, uniqueness: { scope: [:bet_id, :answer], message: "You've already voted on this bet" }

  #validates :username, uniqueness: { scope: [:bet_id, :answer], message: "This username already voted on this bet" }

  after_create :increment_bet_vote_count

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

  private

    def increment_bet_vote_count

      if self.answer == "a"
        self.bet.increment(:answer_a_count).save
      elsif  self.answer == "b"
        self.bet.increment(:answer_b_count).save
      end
    end

end
