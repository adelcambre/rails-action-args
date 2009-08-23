module AbstractController
  class BadRequest < StandardError; end
  
  module ActionArgs

    def self.included(base)

      base.class_eval do
        class << self
          attr_accessor :action_argument_list
          alias_method :old_inherited, :inherited

          # Stores the argument lists for all methods for this class.
          #
          # ==== Parameters
          # klass<Class>::
          #   The controller that is being inherited from Merb::AbstractController.
          def inherited(klass)
            klass.action_argument_list = Hash.new do |hash,action|
              args = klass.instance_method(action).get_args
              arguments = args[0]
              defaults = []
              arguments.each {|a| defaults << a[0] if a.size == 2} if arguments
              hash[action] = [arguments || [], defaults]
            end
            old_inherited(klass)
          end
        end

        alias :old_send_action :send_action
        # Calls an action and maps the params hash to the action parameters.
        #
        # ==== Parameters
        # action<Symbol>:: The action to call
        #
        # ==== Raises
        # BadRequest:: The params hash doesn't have a required parameter.
        def send_action(action)
          arguments, defaults = self.class.action_argument_list[action.to_s]

          args = arguments.map do |arg, default|
            p = params.key?(arg.to_sym)
            unless p || (defaults && defaults.include?(arg))
              missing = arguments.reject {|arg| params.key?(arg[0].to_sym || arg[1])}
              raise BadRequest, "Your parameters (#{params.inspect}) were missing #{missing.join(", ")}"
            end
            p ? params[arg.to_sym] : default
          end
          old_send_action(action, *args)
        end
      end
    end
  end
end

AbstractController::Base.send(:include, AbstractController::ActionArgs)