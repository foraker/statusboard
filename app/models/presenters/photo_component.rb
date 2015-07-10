module Presenters
  class PhotoComponent < StatusBoardComponent

    #this will need to be updated to check if there's actually an image
    def has_image_url?
      !url.empty?
    end
  end
end
