class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_filter :authenticate_user!, :login_first_user

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  rescue_from CanCan::AccessDenied do |exception|
    begin
      redirect_to :back, alert: exception.message
    rescue
      redirect_to root_path, alert: exception.message
    end
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_first_user
    sign_in(User.last)

  end

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "This area is restricted to administrators only."
      redirect_to destroy_user_session_path
    end
  end

  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end

  protected
  def user_for_paper_trail
    user_signed_in? ? current_user.try(:id) : 'Unknown user'
  end

  def layout_by_resource
    devise_controller? ? 'blank' : 'application'
  end
end
