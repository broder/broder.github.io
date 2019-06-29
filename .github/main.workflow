workflow "Test" {
  on = "push"
  resolves = ["Lint: Ruby", "Test: HTML", "Test: AMP", "Test: Accessibility"]
}

workflow "Release" {
  on = "release"
  resolves = "Deploy"
}

action "Init: Bundler" {
  uses = "./actions/jekyll-dev"
  args = "bundle install"
}

action "Init: Git" {
  uses = "./actions/jekyll-dev"
  args = "actions/jekyll-dev/init-git.sh"
}

action "Init: NPM" {
  uses = "./actions/jekyll-dev"
  args = "npm install"
}

action "Lint: Ruby" {
  needs = "Init: Bundler"
  uses = "./actions/jekyll-dev"
  args = "bundle exec rake lint_ruby"
}

action "Build" {
  needs = ["Init: Bundler", "Init: Git"]
  uses = "./actions/jekyll-dev"
  args = "bundle exec rake build"
}

action "Test: HTML" {
  needs = "Build"
  uses = "./actions/jekyll-dev"
  args = "bundle exec rake test_html"
}

action "Test: AMP" {
  needs = ["Init: NPM", "Build"]
  uses = "./actions/jekyll-dev"
  args = "bundle exec rake test_amp"
}

action "Test: Accessibility" {
  needs = ["Init: NPM", "Build"]
  uses = "./actions/jekyll-dev"
  args = "bundle exec rake test_accessibility"
}

action "Deploy" {
  needs = ["Lint: Ruby", "Test: HTML", "Test: AMP", "Test: Accessibility"]
  uses = "./actions/jekyll-dev"
  args = "./actions/jekyll-dev/deploy.sh"
  secrets = ["GITHUB_TOKEN"]
}
