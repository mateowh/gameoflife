# Game Of Life Challenge

A kata to solve [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

## Rules

The user inputs a two-dimensional grid of characters, with cells represented as:
- `.` => `dead`
- `O` => `living`

This is iterated over subject to these rules:
- Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by overpopulation.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The state of each 'cell' is updated and the result returned to the standard output.

## Run it

If you don't have it already, install ruby (this was built on `2.6.3`).

[_TODO - dockerise this to prevent any dependency issues_]

## Running tests and linter

Run `bundle install`

To use the linter run `bundle exec rubocop`
To execute the tests run `bundle exec rspec`

Given an input file `testfile`, run this for one iteration:

`cat testfile | ruby gameoflife.rb`

There is an example `testfile` in the repository.

## Assumptions
- only one input from the user