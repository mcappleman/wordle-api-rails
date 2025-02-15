class GuessesController < ApplicationController
  before_action :set_guess, only: %i[ show update destroy ]

  # POST /guesses
  def create
    @guess = Guess.new(guess_params)

    if @guess.save
      wordle = Wordle.find(@guess.wordle_id)
      wordle.check_guess(@guess.word)
      wordle.game_over?
      render json: wordle.to_json, status: :created, location: wordle
    else
      render json: @guess.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def guess_params
      params.permit(:word, :wordle_id)
    end
end
