class AppToken < ApplicationRecord

  belongs_to :api_app
  scope :enableds, -> {where(state: "enabled")}

  validates_presence_of :api_app_id

  before_create :generate_access_token

  state_machine :state, initial: :enabled do

    event :disable do
      transition enabled: :disabled
    end

    event :enable do
      transition disabled: :enabled
    end

  end

  private

  def generate_access_token
    self.access_token = SecureRandom.urlsafe_base64(32)
  end

end