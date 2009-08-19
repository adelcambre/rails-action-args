# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails-action-args}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andy Delcambre"]
  s.date = %q{2009-08-19}
  s.email = %q{adelcambre@engineyard.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/rails_action_args.rb",
    "lib/rails_action_args/abstract_controller.rb",
    "lib/rails_action_args/get_args.rb",
    "lib/rails_action_args/jruby_args.rb",
    "lib/rails_action_args/mri_args.rb",
    "lib/rails_action_args/vm_args.rb",
    "spec/controllers/action_args.rb",
    "spec/rails_action_args_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/adelcambre/rails-action-args}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A port of merb-action-args to Rails 3}
  s.test_files = [
    "spec/controllers/action_args.rb",
    "spec/rails_action_args_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
