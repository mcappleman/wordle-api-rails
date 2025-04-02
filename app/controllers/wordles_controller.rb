class WordlesController < ApplicationController
  before_action :set_wordle, only: %i[ show update destroy ]

  # GET /wordles
  def index
    parameters = params.permit(:status)
    parameters[:user_id] = @current_user.id
    @wordles = Wordle.where(parameters)

    render json: @wordles.to_json(include: [ :guesses, { boards: { include: { board_rows: { include: :board_cells } } } } ])
  end

  # GET /wordles/1
  def show
    render json: @wordle.to_json(include: [ :guesses, { boards: { include: { board_rows: { include: :board_cells } } } } ])
  end

  # POST /wordles
  def create
    @wordle = Wordle.new(wordle_params)
    @wordle.user_id = @current_user.id
    @wordle.max_guesses = @wordle.num_of_boards + 5
    @wordle.status = "active"

    if @wordle.save
      @wordle.create_boards
      render json: @wordle.to_json(include: [ :guesses, { boards: { include: { board_rows: { include: :board_cells } } } } ]), status: :created, location: @wordle
    else
      render json: @wordle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wordles/1
  def destroy
    @wordle.destroy!
  end

  private
    def set_wordle
      @wordle = Wordle.find(params.expect(:id))
    end

    def wordle_params
      params.permit(:num_of_boards)
    end
end
