class WordlesController < ApplicationController
  before_action :set_wordle, only: %i[ show update destroy ]

  # GET /wordles
  def index
    parameters = params.permit(:status)
    parameters[:user_id] = @current_user.id
    @wordles = Wordle.where(parameters)
    games = []
    @wordles.each do |wordle|
      games << wordle.to_json
    end

    render json: games
  end

  # GET /wordles/1
  def show
    render json: @wordle.to_json
  end

  # POST /wordles
  def create
    @wordle = Wordle.new(wordle_params)
    @wordle.user_id = @current_user.id
    @wordle.max_guesses = @wordle.num_of_boards + 5
    @wordle.status = "active"

    if @wordle.save
      @wordle.create_boards
      render json: @wordle.to_json, status: :created, location: @wordle
    else
      render json: @wordle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wordles/1
  def destroy
    @wordle.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wordle
      @wordle = Wordle.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def wordle_params
      params.permit(:num_of_boards)
    end
end
