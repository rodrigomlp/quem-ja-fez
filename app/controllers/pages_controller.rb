class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :info]

  def home # home
    @university = "Universidade"
    @course = "Curso"
  end

  def about # about us
  end

  def info # undergrad sign up explanation page
  end

  private


end
