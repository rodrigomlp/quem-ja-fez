class FeedbacksController < ApplicationController
  def new
    # Empty
  end

  def create
    if params[:feedback] != "" # If feedback was given
      # send e-mail
    else # If no feedback was given
      render :new
    end
  end
end
