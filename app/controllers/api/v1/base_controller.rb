module API
  module V1
    class BaseController < ActionController::Base
      before_action :authenticate

      private

      def authenticate
        @admin = Admin.find_by_API_token!(status_params[:API_token])
      rescue ActiveRecord::RecordNotFound
        return render status: :unauthorized,
                      json: {
                        error: I18n.t('api-errors.unauthorized'),
                        status: :unauthorized
                      }
      end

      def status_params
        params.permit(
          :API_token
        )
      end
    end
  end
end
