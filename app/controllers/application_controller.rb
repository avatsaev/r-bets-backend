class ApplicationController < ActionController::API

  def health_check
    render json: {
        EC2_REGION: ENV['EC2_REGION'],
        instance_id: ENV['EC2_INSTANCE_ID'],
        avail_zone: ENV['EC2_AVAIL_ZONE'],
        host: request.host
    }, status: :ok
  end
end
