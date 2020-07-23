# Game Of Life Challenge

A program to solve the [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) kata.

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
- Any live cell with < 2 live neighbours dies
- Any live cell with 2-3 live neighbours lives on
- Any live cell with > 3 live neighbours dies
- Any dead cell with exactly 3 live neighbours becomes a live cell

The state of each 'cell' is updated and the result returned to the standard output in the same format as the input.

## Run it

If you don't have it already, install `ruby` (this was built on `2.6.3`).

The game accepts text through the standard input. Given an input file `testfile`, run this for one iteration of the game:

`cat testfile | ruby gameoflife.rb`

There is a folder of example files `dummy_test_files` in the repository which can be used for testing.

## Running tests and linter

N.B - You will need [`Bundler`](https://bundler.io/) installed for these next steps.

- Run `bundle install` to install the ruby gems
- To use the linter run `bundle exec rubocop`
- To execute the tests (and test coverage) run `bundle exec rspec`

## Structure

There is one overarching class - called `GameGenerator`, which is initialized and called from the `gameoflife.rb` script file.

The `GameGenerator` runs the iteration of the game by delegating responsibilities out to other classes in turn:

- The `GridFactory` takes the input given by the user and creates a 2-dimensional `Array` (grid) of `Cell` classes
- The `GridIterator` takes the game grid and iterates it once, based on the 4 rules listed above
- The `Presenter` takes the iterated grid of `Cell` classes and returns it to the user in the correct format (`.` & `O`)

## Other things to do if I had more time

- Dockerise the project to prevent any dependency issues, and make the setup easier
- Add [Sorbet](https://sorbet.org/) typing
- Add a wider range of tests. I'm happy with the test coverage at the moment, but there's always room to be more thorough!