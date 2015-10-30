class My::ReviewsController < My::BaseController

  def index
    @reviews = Review.where(user_id: current_user.id)
  end

end