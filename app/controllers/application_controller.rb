class ApplicationController < ActionController::API

  def health_check
    render json: {}, status: :success
  end
end
