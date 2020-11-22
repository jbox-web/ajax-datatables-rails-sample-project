# frozen_string_literal: true

module BaseController
  module Sessions
    module User
      extend ActiveSupport::Concern

      private


        def session_scope
          @session_scope ||= self.class.name.gsub('Controller', '').underscore.downcase.to_sym
        end


        def get_data_in_session(key, scope = session_scope)
          session.dig(scope, key)
        end


        def set_data_in_session(key, value, scope = session_scope)
          session[scope]    ||= {}
          session[scope][key] = value
          # session.save
          # session.reload
        end


        # rubocop:disable Metrics/CyclomaticComplexity, Layout/CommentIndentation
        def get_selected_ids(scope = session_scope)
          data  = get_data_in_session(:selected, scope) || []
          data += params[:ids].map(&:to_i) if params[:ids]
          data += params[:selected].map(&:to_i) if params[:selected]
          data -= params[:not_selected].map(&:to_i) if params[:not_selected]
          data.uniq.sort
        end
        # rubocop:enable Metrics/CyclomaticComplexity, Layout/CommentIndentation

    end
  end
end
