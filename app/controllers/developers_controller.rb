class DevelopersController < ApplicationController
  before_action :authenticate_apis
  before_action :set_developer, only: [:show]

  def index
    @developers = Developer.where search_params

    render_ok @developers
  end

  def show
    render_ok @developer
  end

  private

  def set_developer
    @developer = Developer.find(params[:id])
  end
  
  def search_params
    params.permit(:name, :age)
  end
end
