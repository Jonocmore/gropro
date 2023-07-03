class ResourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @resources = Resource.all

    # Search

    popular = params[:popular]

    if params[:query].present?
      @resources = Resource.search_by_title(params[:query])
    else
      @resources = if popular.present?
        Resource.where(popular: true)
      else
        Resource.order(:title)
    end
  end
end

  def show
  end

end
