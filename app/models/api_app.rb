class ApiApp < ApplicationRecord

  has_many :app_tokens


  scope :enableds, -> {where(state: "enabled")}

  after_create :generate_app_token

  state_machine :state, initial: :enabled do

    event :disable do
      transition enabled: :disabled
    end

    event :enable do
      transition disabled: :enabled
    end

    after_transition on: :disable, do: :invalidate_all_tokens

  end

  private

    def generate_app_token
      app_token = self.app_tokens.new
      app_token.save
    end




    def invalidate_all_tokens
      self.app_tokens.each {|token| token.disable}
    end


end
