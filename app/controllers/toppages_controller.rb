class ToppagesController < ApplicationController
  def index
    if logged_in?
      # @tasks = current_user.tasks.build
    end
  end
end