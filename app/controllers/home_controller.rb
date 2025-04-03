class HomeController < ApplicationController
  def page
  end

  def level
    session.delete(:selected_chapter)
  end
end
