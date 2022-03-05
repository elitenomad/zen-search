# Zen::Search

`Zen::Search` is a simple command line application to search the user and tickets data and return the results in a human readable format.

# Prerequistes

    Data available as 
       1. tickets.json
       2. users.json

# Goal statements (From specification PDF)

   1. Feel free to use libraries or roll your own code as you see fit. However, please do not use a
    database or full text search product as we are interested to see how you write the solution.
   2. Where the data exists, values from any related entities should be included in the results, i.e.
    searching tickets should return their assigned user and searching users should return their assigned tickets.
   3. The user should be able to search on any field. Full value matching is fine (e.g. "mar" won't
    return "mary")
   4. The user should also be able to search for missing values, e.g. where a ticket does not have
    an assignee_id.

### Input data

├── data 
│   ├── tickets.json
│   ├── users.json

## Development or Installation

Download the zen-search.zip into your local folder (OR)

```
git clone git@github.com:elitenomad/zen-search.git
cd zen-search
bundle install

(or)

cd zen-search
bin/setup

```

- After checking out the repo, run `bin/setup` to install dependencies.
- Then, run `rake spec` to run the tests. 
- You can also run `bin/console` for an interactive prompt that will allow you to experiment.
    
## Directory structure

```
├── CHANGELOG.md
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── bin
│   ├── console
│   └── setup
├── data
│   ├── tickets.json
│   └── users.json
├── exe
│   └── simulator
├── lib
│   └── zen
│       ├── search
│       │   ├── cli.rb
│       │   ├── generate
│       │   ├── loader.rb
│       │   ├── parse.rb
│       │   ├── services
│       │   │   ├── core.rb
│       │   │   ├── fields.rb
│       │   │   ├── print.rb
│       │   │   ├── tickets.rb
│       │   │   └── users.rb
│       │   ├── tickets.rb
│       │   ├── users.rb
│       │   └── version.rb
│       └── search.rb
├── spec
└── zen-search.gemspec
```

## Usage

Note: Ensure latest ruby is installed on the system.

1. Unzip the zen-search.zip
2. cd zen-search
3. Run simulator with filename as argument.
4. `chmod ugo+x exe/simulator` (not required, in case its not recognised as a script)

```
./exe/simulator

```
## Test

```
rspec spec/
```

or

```
rake spec
```
# Design and Considerations

- Use `bundle gem` to create a standard folder structure, Reasons are 
    - To ensure the gem acts like a `cmd` tool to start with. 
    - To ensure the gem could be used for API wrappers in future.
- Use `tty-prompt` to have interactive selection of options.
- Use `tty-table` to print the result in human readable format (Used :ascii option).
- Use `pry` to debug the issues.
- Use `rubocop` to maintain development standard guide.
- When simulator is started
    - Loads the data
    - Indexes the data (TODO)
- When an option is selected,
    - Lookup both the JSON files and combine the records and display (Brute force)
    - Lookup for the right indexes and display the output (TODO)
- Command Line UI design is based on specification document.

## Assumptions

1. Limited to the datasets provided in the problem statement. Data with huge sizes are not explored
2. Assumed all data can fit into memory on a single machine (Based on specification statement).
3. Any file which has `users` is assumed to have users information.
4. Any file which has `tickets` is assumed to have tickets information.
5. State is not maintained with option selection in command line. For e.g you choose `View Searchable Fields => Users`, After
   output is displayed, the tool will reset to the first option of `Search Zendesk`
6. Took liberty to establish relationship between entities. 

## Scope for Enhancement

- Used a `tty-table` to display the output to terminal. Used a basic option and didn't explore advanced options in it to improve it.
- Could have used a gem called `mutations` to have schema based services. Tried to acheive the functionality with ruby classes but would have been a nice addition.
- Rubocop script is manually run, could be automated onto git lifecycle hooks to run before we commit the code.

## Local terminal output

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
