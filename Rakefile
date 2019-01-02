require 'html-proofer'
require 'rubocop/rake_task'

build_folder = './_site'

task :clean do
  `git fetch`
  `cd #{build_folder} && git checkout -f origin/master`
end

task :build do
  system "JEKYLL_ENV=production bundle exec jekyll build --destination #{build_folder}"
end

task :deploy do
  msg = `git log --oneline -1 | cat`
  msg.sub!("\n", '')
  `cd #{build_folder} && git add .`
  `cd #{build_folder} && git commit -m "🚀 updated build to '#{msg}'"`
  `cd #{build_folder} && git push origin HEAD:master`
end

task :generate_logos do
  `git submodule init`
  `git submodule update`
  `cd logos && npm i`
  `cd logos && npm run export -- --outDir ../assets/logos`
end

task test: %w[lint_ruby test_html test_amp test_accessibility]

RuboCop::RakeTask.new(:lint_ruby) do |t|
  t.options = ['--display-cop-names']
end

task :test_html do
  HTMLProofer.check_directory(build_folder, assume_extension: true, disable_external: true, url_ignore: [/dbr.ie/]).run
end

task :test_amp do
  files = Dir["./#{build_folder}/amp/**/*.html"].select { |f| File.file? f }
  success = true
  files.each do |file|
    success &&= system "node_modules/.bin/amphtml-validator #{file}"
  end
  raise unless success
end

task :test_accessibility do
  files = Dir["./#{build_folder}/**/*.html"].select { |f| File.file?(f) && !f.include?('/amp/') }
  success = true
  pa11y_command = 'node_modules/.bin/pa11y'
  pa11y_command << " --config #{ENV['PA11Y_CONFIG']}" if ENV['PA11Y_CONFIG'] # For running in Docker
  files.each do |file|
    success &&= system "#{pa11y_command} #{file}"
  end
  raise unless success
end
