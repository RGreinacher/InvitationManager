module API
  module V1
    class GuestListController < BaseController

      def show
        all_guests = Guest.all
        participating = query_guests(participating: 3)
        not_sure = query_guests(participating: 2)
        turned_down = query_guests(participating: 1)
        undecided = query_guests('sign_in_count > 0 and participating = 0')
        never_logged_in = query_guests(sign_in_count: 0)

        render json: {
          guests: {
            participating: map_companions(participating),
            not_sure: map_companions(not_sure),
            turned_down: map_companions(turned_down),
            undecided: map_companions(undecided),
            never_logged_in: map_companions(never_logged_in)
          },
          numbers: {
            invited: (all_guests.count + all_guests.sum(:companions)),
            participating: (participating.count + participating.sum(:companions)),
            not_sure: (not_sure.count + not_sure.sum(:companions)),
            turned_down: (turned_down.count + turned_down.sum(:companions)),
            undecided: (undecided.count + undecided.sum(:companions)),
            never_logged_in: never_logged_in.count
          },
          title: t('navigation.title'),
          headline: t('guests.index.headline')
        }
      end

      private

      def query_guests(where)
        Guest.where(where)
             .order(updated_at: :desc)
      end

      def map_companions(guests)
        guests.map do |guest|
          if guest.companions > 0
            "#{guest.name} +#{guest.companions}"
          else
            guest.name
          end
        end
      end

    end
  end
end
