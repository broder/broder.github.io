# broder.github.io

## Requirements

### Required
* Ruby
* Bundler (`gem install bundler`)

### Optional
* Node.js (for test dependencies)


## Setup
1. Clone the repository.
2. `cd` to the cloned directory.
3. Checkout the `src` branch by running `git checkout src`.
4. Install the dependencies by running `bundle install`.
5. Add a git worktree for deployment by running `git worktree add ./_site origin/master`.
6. Launch the site with `bundle exec jekyll serve`.


## Add new posts
Add a new `.md` file in `_posts/` using existing posts as examples.


## Testing
1. Install the test dependencies by running `npm i`.
2. Run `bundle exec rake test`.


## Deployment
Run `bundle exec rake deploy`.


## Generating logos
Run `bundle exec rake generate_logos` (you may need to install some extra dependencies as described in `logos/README.md`).
