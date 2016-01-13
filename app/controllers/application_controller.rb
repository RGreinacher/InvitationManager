class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
    ap admin_signed_in?
    ap guest_signed_in?
    ap params
    ap current_guest
    return true if admin_signed_in?
    return true if params[:id] == current_guest.id.to_s
    ap 'auth guest'
    # redirect_to edit_guest_path(current_guest)
    authenticate_admin!
    # return true if params[:guest] && params[:id] == 'edit'
    # guest_check_id = params[:guest_id] || params[:id]
    # authenticate_admin! if current_guest.id != guest_check_id.to_i
    # if params[:controller] == 'people' && params[:action] != 'new' && params[:action] != 'create'
    #   if params[:action] == 'destroy_image'
    #     person_check_id = params[:person_id]
    #   else
    #     person_check_id = params[:id]
    #   end
    #   authenticate_admin! if Person.find(person_check_id).guest != current_guest
    # end
  end
end
