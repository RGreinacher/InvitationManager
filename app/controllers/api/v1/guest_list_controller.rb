module API
  module V1
    class GuestListController < BaseController

      def show
        participating_guests = Guest.where(participating: 3).order(:updated_at).map { |guest| guest.name }
        not_sure_guests = Guest.where(participating: 2).order(:updated_at).map { |guest| guest.name }
        turned_down_guests = Guest.where(participating: 1).order(:updated_at).map { |guest| guest.name }
        undecided_guests = Guest.where('sign_in_count > 0 and participating = 0').order(:updated_at).map { |guest| guest.name }
        never_logged_in_guests = Guest.where(sign_in_count: 0).order(:updated_at).map { |guest| guest.name }

        render json: {
          participating: participating_guests,
          not_sure: not_sure_guests,
          turned_down: turned_down_guests,
          undecided: undecided_guests,
          never_logged_in: never_logged_in_guests
        }
      end

    end
  end
end
