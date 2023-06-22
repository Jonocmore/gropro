class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:home]

  # Other code in your ApplicationController

  private

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      user_gardens_path(resource)
    else
      super
    end
  end
end
