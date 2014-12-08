class HomeController < ApplicationController
  before_filter :set_after_sign_in_path, only: [:index]

  def index
  end


end
