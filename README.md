# Linguist #

Linguist is a command line tool which returns most used programming language for a given Github username.

It's been written as a code test assignment for a client.

## Goals ##

  - keep the tool light and not over-engineer it from the very start,
  - keep dependencies to as little as none.
  - meet 5 lines of code per method rule.

## Dependencies ##

  - Ruby 2.0

## Usage  ##

  `ruby linguist.rb -h` – shows information about usage.

  `ruby linguist.rb -u GITHUB_USERNAME` – displays the name of most frequently used programming language per user.

## Notes ##

- The command line app does not use any authentification. Respect the http://developer.github.com/v3/#rate-limiting.
