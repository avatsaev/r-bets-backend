class Api::V1::ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :auth_request

  protected

    def auth_request

      authenticate_or_request_with_http_token do |token, options|

        @app_token = AppToken.enableds.find_by_access_token(token)

        if @app_token.present?

          @api_app = @app_token.api_app

          unless @api_app.test_mode

            origin_domain = URI.parse(request.referrer).host if request.referrer

            p "////////////////// origin referer: #{origin_domain}"

            if @api_app.web_app and @api_app.origin_domain != origin_domain

              render json: {
                  status: 'error',
                  error: "Invalid request origin domain #{origin_domain}"
              }, status: :unauthorized

            else true

            end


          else true

          end

        else

          render json: {
              status: 'error',
              error: "Invalid API key"
          }, status: :unauthorized

        end


      end

    end
end
