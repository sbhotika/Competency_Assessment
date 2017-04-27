class HomeController < ApplicationController
  layout "admin", only: [:dashboard]

  # GET / (a.k.a root_path)
  def home
  end

  # GET /about
  def about
  end

  # GET /dashboard
  def dashboard
    @active_competencies = Competency.active.alphabetical
    @inactive_competencies = Competency.inactive.alphabetical
    @levels = Level.active.by_ranking
    @paradigms = Paradigm.active.by_ranking
  end

end
