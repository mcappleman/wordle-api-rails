class MeController < ApplicationController
  # GET /me
  def index
    render json: @current_user.to_json
  end

  # PATCH/PUT /me
  def update
    if user_params[:current_password].present? && user_params[:password].blank?
      render json: { error: "Password is required" }, status: :unprocessable_entity
      return
    end

    if user_params[:current_password].blank? && user_params[:password].present?
      render json: { error: "Current password is required" }, status: :unprocessable_entity
      return
    end

    if user_params[:current_password].present? && user_params[:password].present? && user_params[:password] != user_params[:password_confirmation]
      render json: { error: "Password confirmation does not match" }, status: :unprocessable_entity
      return
    end

    if user_params[:current_password].present? && user_params[:password].present?
      if user_params[:current_password] == user_params[:password]
        render json: { error: "New password cannot be the same as the current password" }, status: :unprocessable_entity
        return
      end

      if @current_user.authenticate(user_params[:current_password])
        @current_user.update(user_params.except(:current_password))
      else
        render json: { error: "Current password is incorrect" }, status: :unauthorized
        return
      end
    end

    if @current_user.update(user_params.except(:current_password, :password, :password_confirmation))
      render json: @current_user.to_json
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /me
  def destroy
    binding.pry
    @current_user.destroy!
    render json: { message: "User deleted successfully" }, status: :ok
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :current_password, :password, :password_confirmation)
  end
end
