class Bet < ApplicationRecord


  validates :title, presence: true
  validates :answer_a, presence: true
  validates :answer_b, presence: true

  has_many :votes


  state_machine :state, initial: :opened do

    event :close do
      transition opened: :closed
    end

    after_transition on: :close, do: :finalize_results

  end


  def as_json(opts={})

    json = {}

    json = json.merge({
      id: id,
      title: title,
      answer_a: answer_a,
      answer_b: answer_b,
      answer_a_count: answer_a_count,
      answer_b_count: answer_b_count,
      state: state,
      ends_at: ends_at,
      created_at: created_at,
    })

    json

  end


  private

    def finalize_results

      self.answer_a_count = self.votes.where(answer: "a").count
      self.answer_b_count = self.votes.where(answer: "b").count
      self.save!

    end

end
