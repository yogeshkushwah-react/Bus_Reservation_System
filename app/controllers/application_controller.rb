class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def not_found
    render file: "public/404.html", status: :not_found
  end

  private

  def user_not_authorized
    render file: "public/401.html", status: :unauthorized
  end
end
