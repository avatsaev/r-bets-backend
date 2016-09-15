class Api::V1::BetsController < ApplicationController

  before_action :set_bet, only: [:show, :update, :destroy]

  # GET /bets
  def index

    if params[:last]
      @bets = Bet.last(params[:last])
    else
      @bets = Bet.all
    end

    render json: {
        bets: @bets,
        status: 'success',
        error: nil
      }, status: :ok

  end

  # GET /bets/1
  def show
    if @bet.present?
      render json: {
          bet: @bet,
          status: 'success',
          error: nil
      }, status: :ok
    else
      render json: {
        bet: nil,
        status: 'error',
        error: 'Bet not found'
      }, status: :not_found
    end

  end

  # POST /bets
  def create
    @bet = Bet.new(bet_params)

    if @bet.save
      render json: @bet, status: :created, location: api_v1_bet_url(@bet)
    else
      render json: @bet.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /bets/1
  # def update
  #   if @bet.update(bet_params)
  #     render json: @bet
  #   else
  #     render json: @bet.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /bets/1
  # def destroy
  #   @bet.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet
      @bet = Bet.find_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bet_params
      params.require(:bet).permit(:title, :answer_a, :answer_b, :ends_at, :state)
    end


end
