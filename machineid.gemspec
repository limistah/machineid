require File.expand_path('lib/machineid/version', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'machineid'
  spec.version = machineid::VERSION
  spec.authors = ['Aleem Isiaka']
  spec.email = ['aleemisiaka@gmail.com']
  spec.description = "Ruby GEM to Get a machine's ID"
  spec.summary = "Use machineid in your Ruby projects"
  spec.homepage= 'https://github.com/limistah/machineid'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'

  spec.files = Dir['README.md', 'LICENSE', 'CHANGELOG.md', 'lib/**/*.rb', 'lib/**/*.rake', 'machineid.gemspec', '.github/*.md', 'Gemfile', 'Rakefile']

  spec.extra_rdoc_files = ['README.md']

  spec.add_dependency 'rubyzip', '~> 2.3'

  spec.add_development_dependency 'rubocop', '~> 0.60'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.37'
end