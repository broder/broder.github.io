# broder.github.io
## Requirements
* Ruby >= 2.0.0
* Bundler (`gem install bundler`)

## Setup
1. Clone the repository.
2. `cd` to the cloned directory.
3. Checkout the `src` branch by running `git checkout src`.
2. Install the dependencies by running `bundle install`.
3. Add a git worktree for deployment by running `git worktree add ./_site origin/master`.
4. Launch the site with `bundle exec jekyll serve`.

## Add new posts
Add a new `.md` file in `_posts/` using existing posts as examples.

## Deployment
Run `./deploy.sh`.
