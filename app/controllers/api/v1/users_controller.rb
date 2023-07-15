module Api
  module V1
    class UsersController < Api::V1::BaseController
      def me
        render json: current_user, status: :ok
      end

      def index
        @users = User.all
        render json: @users, status: :ok
      end
    end
  end
end