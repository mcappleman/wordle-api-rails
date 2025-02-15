class WordlesController < ApplicationController
  before_action :set_wordle, only: %i[ show update destroy ]

  # GET /wordles
  def index
    @wordles = Wordle.all

    render json: @wordles
  end

  # GET /wordles/1
  def show
    render json: @wordle
  end

  # POST /wordles
  def create
    @wordle = Wordle.new(wordle_params)

    if @wordle.save
      render json: @wordle, status: :created, location: @wordle
    else
      render json: @wordle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /wordles/1
  def update
    if @wordle.update(wordle_params)
      render json: @wordle
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
      params.expect(wordle: [ :status ])
    end
end
