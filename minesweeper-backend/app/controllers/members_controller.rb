class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: { email: current_user.email, message: "Signed in" }
  end
end
