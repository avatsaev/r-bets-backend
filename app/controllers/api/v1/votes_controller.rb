class Api::V1::VotesController < ApplicationController


  # before_action :set_vote, only: [:show, :update, :destroy]
  before_action :set_bet, only: [:index, :create]

  # GET /votes
  def index
    @votes = @bet.votes

    render json: @votes
  end

  # GET /votes/1
  # def show
  #   render json: @vote
  # end

  # POST /votes
  def create
    @vote = @bet.votes.new(vote_params)
    @vote.ip_addr = request.remote_ip

    if @vote.save
      render json: @vote, status: :created, location: api_v1_bet_votes_url(@bet, @vote)
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /votes/1
  # def update
  #   if @vote.update(vote_params)
  #     render json: @vote
  #   else
  #     render json: @vote.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /votes/1
  # def destroy
  #   @vote.destroy
  # end

  # private
    # Use callbacks to share common setup or constraints between actions.
    # def set_vote
    #   @vote = Vote.find(params[:id])
    # end

    def set_bet
      @bet = Bet.find(params[:bet_id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.require(:vote).permit(:username, :answer)
    end


end
