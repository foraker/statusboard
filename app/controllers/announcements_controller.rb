class AnnouncementsController < ApplicationController
  def index
    announcement = Announcement.unannounced.oldest_first.first
    announcement.announced! if announcement
    render json: announcement
  end
end
