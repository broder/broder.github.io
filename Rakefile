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

RuboCop::RakeTask.new(:validate_ruby) do |t|
  t.options = ['--display-cop-names']
end

task :validate_html do
  HTMLProofer.check_directory(build_folder, assume_extension: true, disable_external: true).run
end

task :validate_amp do
  files = Dir["./#{build_folder}/amp/**/*.html"].select { |f| File.file? f }.map { |f| File.absolute_path f }
  success = true
  files.each do |file|
    success &&= system "node_modules/.bin/amphtml-validator #{file}"
  end
  raise unless success
end

task :validate_accessibility do
  files = Dir["./#{build_folder}/**/*.html"].select { |f| File.file? f }.map { |f| File.absolute_path f }
  success = true
  files.each do |file|
    success &&= system "node_modules/.bin/pa11y file://#{file}"
  end
  raise unless success
end

task test: %w[validate_ruby build validate_html validate_amp validate_accessibility]

task deploy: %w[clean build] do
  msg = `git log --oneline -1 | cat`
  msg.sub!("\n", '')
  `cd #{build_folder} && git add .`
  `cd #{build_folder} && git commit -m "🚀 updated build to '#{msg}'"`
  `cd #{build_folder} && git push origin HEAD:master`
end
