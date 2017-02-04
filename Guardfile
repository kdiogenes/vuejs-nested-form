guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard 'annotate' do
  watch( 'db/schema.rb' )
end

guard :foreman, procfile: 'Procfile', port: 5000 do
  # Rails example - Watch controllers, models, helpers, lib, and config files
  # watch( /^app\/(controllers|models|helpers)\/.+\.rb$/ )
  # watch( /^lib\/.+\.rb$/ )
  watch( /^config\/*/ )
  watch('config/**/*')
  ignore(/config\/routes.rb/)
end

def rspec_guard_rules
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      rspec.spec.call("acceptance/#{m[1]}")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.call("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end
end

rspec_parallel_options = {
  run_all: {
    cmd: "DISABLE_SPRING=0 bundle exec parallel_rspec -o '",
    cmd_additional_args: "'"
  }
}
group :fast do
  guard :rspec, { cmd: 'spring rspec -t ~js -t ~focus', notification: false }.merge(rspec_parallel_options) do
    rspec_guard_rules
  end
end

group :slow do
  guard :rspec, { cmd: 'spring rspec -t js -t ~focus', notification: false }.merge(rspec_parallel_options) do
    rspec_guard_rules
  end
end

group :focus do
  guard :rspec, cmd: 'spring rspec -t focus', notification: false, all_on_start: true do
    rspec_guard_rules
  end
end
