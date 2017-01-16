class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_copyright_year

  def root
    if params[:token]
      guest = Guest.find_by(token: params[:token])
      sign_in(:guest, guest) if guest
    end

    if guest_signed_in?
      return redirect_to edit_guest_path(current_guest)
    elsif admin_signed_in?
      return redirect_to guests_path
    end

    authenticate_guest!
  end

  private

  def check_guest
    return true if admin_signed_in?
    return true if params[:id] == current_guest.id.to_s
    authenticate_admin!
  end

  def set_copyright_year
    require 'date'
    @current_year = Date.today.strftime("%Y")
  end
end
