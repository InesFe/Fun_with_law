class HomeController < ApplicationController
  def page
    session.delete(:score)
    session.delete(:compteur_questions)
  end

  def level
    session.delete(:selected_chapter)
  end
end
