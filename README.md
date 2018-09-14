**ToyRobot** - Drew Noll ([@oheydrew](http://www.oheydrew.me))
========

Documentation
-------------
- **[PROBLEM.md](./PROBLEM.md)** : The supplied problem outline in full
- **[SOLUTION_NOTES.md](./SOLUTION_NOTES.md)** : Outline of my solution, class breakdown & general mechanics

Installation
------------

I used bundler's `Gemspec` configuration for quick folder / rspec setup, but this gem is **not pushed** to rubygems.org. You can install it locally if you like, using `bundle exec rake install`, but that isn't necessary.

// TODO: More installation instructions

Running Tests
-------------

### Standard RSpec tests

To run the full test suite navigate to the project root (eg: `~/toy_robot/`) and run:

```
~/toy_robot/ $ rspec
```

### Guard-RSpec for auto-running tests

This project has [guard](https://github.com/guard/guard#readme) insatalled with the `guard-rails` plugin. This can automate your tests, watching in the background for any changes. To run tests in this way, run:

```
~/toy_robot/ $ bundle exec guard
```

This will run `guard`, and watch for changes.

Author
------

Drew Noll - <a href="mailto:drew@oheydrew.me">drew@oheydrew.me</a> | <a href="http://www.oheydrew.me">www.oheydrew.me</a>
