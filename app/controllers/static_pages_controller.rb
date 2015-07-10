class StaticPagesController < ApplicationController
  def index
    @status_board = present StatusBoard.new
  end
end
