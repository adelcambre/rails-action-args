class ApplicationController < ActionController::Base
  include ActionArgs
end

module ExtraActions
  # def self.included(base)
  #   base.show_action(:funky_inherited_method)
  # end

  def funky_inherited_method(foo, bar)
    render :text => "#{foo} #{bar}"
  end
end

module Awesome
  class ActionArgsController < ApplicationController
    def index(foo)
      render :text => foo.to_s
    end
  end
end

class ActionArgsController < ApplicationController
  include ExtraActions

  def nada
    render :text => "NADA"
  end

  def index(foo)
    render :text => foo
  end

  def multi(foo, bar)
    render :text => "#{foo} #{bar}"
  end

  def defaults(foo, bar = "bar")
    render :text => "#{foo} #{bar}"
  end

  def defaults_mixed(foo, bar ="bar", baz = "baz")
    render :text => "#{foo} #{bar} #{baz}"
  end

  define_method :dynamic_define_method do
    render :text => "mos def"
  end

  def with_default_nil(foo, bar = nil)
    render :text => "#{foo} #{bar}"
  end

  def with_default_array(foo, bar = [])
    render :text => "#{foo} #{bar.inspect}"
  end

end

