class HomeController < ApplicationController
  before_action :check_login, :except => [:home, :about] 
  layout "admin", only: [:dashboard]

  # GET / (a.k.a root_path)
  def home
  end

  def dashboard
    @active_competencies = Competency.active.alphabetical
    @inactive_competencies = Competency.inactive.alphabetical
    @levels = Level.active.by_ranking
    @paradigms = Paradigm.active.by_ranking
  end

  # GET /about
  def about
  end


end
