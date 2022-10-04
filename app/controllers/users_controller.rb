class UsersController < ApplicationController
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: {errors: e.record.errors.full_messages}, status: 422
    end

    def show
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            render json: user, status: :ok
        else
            render json: {error: "You need to Log in"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
