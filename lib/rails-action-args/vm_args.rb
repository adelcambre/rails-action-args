begin
  require "methopara"
rescue LoadError
  unless RUBY_VERSION >= "1.9.2"
    puts "make sure you have methopara (http://github.com/genki/methopara) installed if you want to use action args with Ruby < 1.9.2"
  end
end

module GetArgs
  def get_args
    unless respond_to?(:parameters)
      raise NotImplementedError, "Ruby #{RUBY_VERSION} doesn't support #{self.class}#parameters"
    end

    required = []
    optional = []

    parameters.each do |(type, name)|
      if type == :opt
        required << [name, nil]
        optional << name
      else
        required << [name]
      end
    end

    return [required, optional]
  end
end
