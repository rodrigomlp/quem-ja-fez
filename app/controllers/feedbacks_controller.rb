class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    # Empty
    @referrer = request.referrer # gets the last page the user was in
  end

  def create
    if params[:feedback] != "" # If feedback was given
      @user = current_user
      UserMailer.user_feedback(params[:feedback], params[:email], params[:referrer], @user).deliver_now
      # flash[:notice] = "Feedback recebido. Obrigado!"
      redirect_to params[:referrer] # Redirect user back to where he came from
    else
      render :new
    end
  end
end
