require 'abstract_controller'
require 'active_support/concern'

# Hook up the BadRequest exception to return 400 Bad Request
class AbstractController::BadRequest < StandardError; end
ActionDispatch::ShowExceptions.rescue_responses["AbstractController::BadRequest"] = :bad_request

module ActionArgs
  extend ActiveSupport::Concern

  module ClassMethods
    def action_arguments(action)
      @action_arguments ||= {}
      return @action_arguments[action] if @action_arguments[action]

      arguments = instance_method(action).get_args.first || []

      defaults = arguments.map do |arg|
        if arg.size == 2
          arg.first
        end
      end.compact
      @action_arguments[action] = [arguments, defaults]
    end
  end

  # Calls an action and maps the params hash to the action parameters.
  #
  # ==== Parameters
  # action<Symbol>:: The action to call
  #
  # ==== Raises
  # BadRequest:: The params hash doesn't have a required parameter.
  def send_action(action)
    arguments, defaults = self.class.action_arguments(action.to_s)

    args = arguments.map do |arg, default|
      p = params.key?(arg.to_sym)
      unless p || (defaults && defaults.include?(arg))
        missing = arguments.reject {|arg| params.key?(arg[0].to_sym || arg[1])}
        raise AbstractController::BadRequest, "Your parameters (#{params.inspect}) were missing #{missing.join(", ")}"
      end
      p ? params[arg.to_sym] : default
    end
    super(action, *args)
  end
end
