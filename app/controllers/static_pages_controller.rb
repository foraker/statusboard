class StaticPagesController < ApplicationController
  def index
    @status_board = StatusBoard.new
  end
end
