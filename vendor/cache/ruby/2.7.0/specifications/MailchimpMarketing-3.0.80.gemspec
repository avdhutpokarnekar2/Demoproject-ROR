# -*- encoding: utf-8 -*-
# stub: MailchimpMarketing 3.0.80 ruby lib

Gem::Specification.new do |s|
  s.name = "MailchimpMarketing".freeze
  s.version = "3.0.80"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mailchimp".freeze]
  s.date = "2022-11-02"
  s.description = "The official Ruby client library for the Mailchimp Marketing API".freeze
  s.email = ["apihelp@mailchimp.com".freeze]
  s.homepage = "https://github.com/mailchimp/mailchimp-client-lib-codegen".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Mailchimp Marketing API Ruby Gem".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<excon>.freeze, [">= 0.76.0", "< 1"])
    s.add_runtime_dependency(%q<json>.freeze, [">= 2.1.0", "~> 2.1"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 3.6.0", "~> 3.6"])
    s.add_development_dependency(%q<vcr>.freeze, ["~> 3.0", ">= 3.0.1"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 1.24", ">= 1.24.3"])
    s.add_development_dependency(%q<autotest>.freeze, ["~> 4.4", ">= 4.4.6"])
    s.add_development_dependency(%q<autotest-rails-pure>.freeze, ["~> 4.1", ">= 4.1.2"])
    s.add_development_dependency(%q<autotest-growl>.freeze, ["~> 0.2", ">= 0.2.16"])
    s.add_development_dependency(%q<autotest-fsevent>.freeze, ["~> 0.2", ">= 0.2.12"])
  else
    s.add_dependency(%q<excon>.freeze, [">= 0.76.0", "< 1"])
    s.add_dependency(%q<json>.freeze, [">= 2.1.0", "~> 2.1"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.6.0", "~> 3.6"])
    s.add_dependency(%q<vcr>.freeze, ["~> 3.0", ">= 3.0.1"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.24", ">= 1.24.3"])
    s.add_dependency(%q<autotest>.freeze, ["~> 4.4", ">= 4.4.6"])
    s.add_dependency(%q<autotest-rails-pure>.freeze, ["~> 4.1", ">= 4.1.2"])
    s.add_dependency(%q<autotest-growl>.freeze, ["~> 0.2", ">= 0.2.16"])
    s.add_dependency(%q<autotest-fsevent>.freeze, ["~> 0.2", ">= 0.2.12"])
  end
end
