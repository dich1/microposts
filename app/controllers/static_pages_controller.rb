class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # show followings when only loggined
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.page((params[:page]))
    end
  end
end