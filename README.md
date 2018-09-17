**ToyRobot** - Drew Noll ([@oheydrew](http://www.oheydrew.me))
========

Documentation
-------------
- **[PROBLEM.md](./PROBLEM.md)** : The supplied problem outline in full
- **[SOLUTION_NOTES.md](./SOLUTION_NOTES.md)** : Outline of my solution, class breakdown & general mechanics

This is my solution to the "Toy Robot" problem, written in Ruby. I had a great time stepping through this problem, from initial concept stages right through to the challenges I found. 

I decided to write this with Test Driven Development, writing Tests first for each desired class, and move into implementation from there. This was useful in many ways, albeit a little slower overall, but that's not such a bad thing, when you're looking for something robust.

Please take a look at my [SOLUTION_NOTES.md](./SOLUTION_NOTES.md) for more information about the implementation, as well as my successes and challenges.

Pre-Requisites
--------------

**Unix-Based OS**: MacOS or Linux preferred, or [Linux Subsystem for Windows](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

**Ruby Version: >2.4.1**: [can be found here](https://www.ruby-lang.org/en/documentation/installation/)

**Bundler** (Ruby Gem): [can be found here](https://bundler.io/)

Installation
------------

To install, simply unzip/clone the contents of this repo to the desired directory and run `bundle install` to install dependencies:

```bash
~/toy_robot/ $ bundle install
```

Then, to run the program, run `run_toy_robot.rb` from the unix command line.

```bash
~/toy_robot/ $ run_toy_robot.rb
```

I used bundler's `Gemspec` configuration for quick folder / rspec setup, but this gem is **not pushed** to rubygems.org. 



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
