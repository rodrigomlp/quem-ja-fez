class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    # Empty
  end

  def create
    if params[:feedback] != "" # If feedback was given
      @user = current_user
      UserMailer.user_feedback(params[:feedback], params[:email], @user).deliver_now
      flash[:notice] = "Feedback recebido. Obrigado!"
      redirect_to :root # TO-DO: Redirect user back to where he came from
    else # If no feedback was given
      render :new
    end
  end
end
