class SessionsController < ApplicationController
  before_action :require_current_user, only: :destroy

  # GET /sessions/new
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: session_params[:username])

    if @user && @user.authenticate(session_params[:password])
      login!(@user)

      redirect_to inbox_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    logout!

    redirect_to new_session_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      @session_params ||= params.require(:session).permit(:username, :password)
    end
end
