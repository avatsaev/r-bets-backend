class Api::V1::VotesController < Api::V1::ApiController


  # before_action :set_vote, only: [:show, :update, :destroy]
  before_action :set_bet, only: [:index, :create]

  # GET /votes
  def index
    @votes = @bet.votes

    render json: {
        votes: @votes,
        status: 'success',
        error: nil
    }, status: :ok

  end

  # GET /votes/1
  # def show
  #   render json: @vote
  # end

  # POST /votes
  def create
    @vote = @bet.votes.new(vote_params)
    @vote.ip_addr = request.remote_ip

    tmp_vote = Vote.where(ip_addr:  @vote.ip_addr,  bet_id: @bet.id)

    if @bet.ended?
      render json: {
          bet: @bet,
          error: "EXPIRED",
          msg: "Bets are closed."
      }, status: :ok
      return

    # elsif tmp_vote.present?
    #   render json: {
    #       status: 'error',
    #       error: "ALREADY_VOTED",
    #       msg: "You've already voted on this"
    #   }, status: :ok
    #   return
    else

      if @vote.answer != "a" and @vote.answer != "b"
        render json: {
            status: 'error',
            error: "INVALID_ANSWER",
            msg: "Invalid answer: #{@vote.answer}"
        }, status: :unprocessable_entity
        return
      end


      if @vote.save

        render json: {
            vote: @vote,
            status: "success",
            error: nil
        }, status: :created, location: api_v1_bet_votes_url(@bet, @vote)

      else
        render json: {
            status: "error",
            error: "unprocessable_entity",
            msg: @vote.errors.full_messages
        }, status: :unprocessable_entity
      end

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
      @bet = Bet.find_by_id(params[:bet_id])

      unless @bet

        render json: {
            status: "error",
            error: "NOT_FOUND",
            msg: "Bet not found"
        }, status: :not_found

      end

    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.require(:vote).permit(:username, :answer)
    end


end
