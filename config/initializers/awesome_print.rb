# require 'action_controller/log_subscriber'

# AwesomePrint.defaults = {
#   indent: 2,
# }

# module ActionController
#   class LogSubscriber < ActiveSupport::LogSubscriber

#     def start_processing(event)
#       return unless logger.info?

#       payload = event.payload
#       params  = payload[:params].except(*INTERNAL_PARAMS)
#       format  = payload[:format]
#       format  = format.to_s.upcase if format.is_a?(Symbol)
#       format  = "*/*" if format.nil?

#       info "Processing by #{payload[:controller]}##{payload[:action]} as #{format}"
#       unless params.empty?
#         info "  Parameters:"
#         ap params
#       end
#     end

#   end
# end
