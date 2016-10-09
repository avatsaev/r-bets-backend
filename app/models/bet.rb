class Bet < ApplicationRecord


  validates :title, presence: true
  validates :answer_a, presence: true
  validates :answer_b, presence: true
  scope :trending, ->{order('created_at DESC, votes_count DESC')}

  has_many :votes


  state_machine :state, initial: :opened do

    event :close do
      transition opened: :closed
    end

    after_transition on: :close, do: :finalize_results

  end

  def as_json(opts={})


    json = {
      id: id,
      title: title,
      answer_a: answer_a,
      answer_b: answer_b,
      answer_a_count: answer_a_count,
      answer_b_count: answer_b_count,
      votes_count: votes_count,
      state: state,
      created_at: created_at,
    }

    if ends_at.present?

      json = json.merge({
                            ends_at: ends_at,
                            ended: ended?
                        })

    end

    json

  end

  def ended?

    if self.closed?
      true
    elsif self.ends_at and self.ends_at < DateTime.now
      self.close
      true
    else
      false
    end

  end

  private

    def finalize_results

      self.answer_a_count = self.votes.where(answer: "a").count
      self.answer_b_count = self.votes.where(answer: "b").count
      self.save!

    end

end
