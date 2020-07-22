# Game Of Life Challenge

A small program to solve the [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

## A brief summary of the rules

The user inputs a two-dimensional grid of characters to standard input, with cells represented as:
- `.` => `dead`
- `O` => `living`

For example:
```
.....
.....
..O.O
OO.O.
..OO.
```

This is iterated over subject to these rules:
- Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by overpopulation.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The state of each 'cell' is updated and the result returned to the standard output.

## Run it

If you don't have it already, install `ruby` (this was built on `2.6.3`).

Given an input file `testfile`, run this for one iteration of the game:

`cat testfile | ruby gameoflife.rb`

There is a folder of example files `dummy_test_files` in the repository which can be used for testing.

## Running tests and linter

N.B - You will need [`Bundler`](https://bundler.io/) installed for these next steps.

- Run `bundle install` to install the ruby gems
- To use the linter run `bundle exec rubocop`
- To execute the tests (and test coverage) run `bundle exec rspec`

## Things I would do if I had more time

- Dockerise the project to prevent any dependency issues, and make the setup easier
- Add [Sorbet](https://sorbet.org/) typing
- Add a wider range of tests. I'm happy with the test coverage I have at the moment, but there's always room to be more thorough!