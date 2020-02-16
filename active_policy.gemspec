require_relative 'lib/active_policy/version'

Gem::Specification.new do |spec|
  spec.name          = "active_policy"
  spec.version       = ActivePolicy::VERSION
  spec.authors       = ["Panos Dalitsouris"]
  spec.email         = ["hello@panos.codes"]

  spec.summary       = "Authorize a request before hitting the controller."
  spec.description   = "Active policy is meant to be a way to authorize a request before hitting the controller."
  spec.homepage      = "https://github.com/PanosCodes/active_policy"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/PanosCodes/active_policy"
  spec.metadata["changelog_uri"] = "https://github.com/PanosCodes/active_policy"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
