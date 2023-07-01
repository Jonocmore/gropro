class ResourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @resources = Resource.all
  end

  def show
  end
end
