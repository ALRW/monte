# Monte

Monte is a simple gem designed to help software engineers and developers answer
the question 'When will it be done?'.

The tool uses the Monte Carlo method to provide a reasonable forecast of the
future based on statistically relevant data from the past.
## Installation

You must have ruby installed to use this tool.

start by installing the gem.

```sh
$ gem install monte
```

## Usage

The following is the simplest version of Monte which should be used when you
have little previous data with which to build your forecast.

```sh
$ monte carlo
 |  \/  |   ___    _ __   | |_    ___
 | |\/| |  / _ \  | '_ \  | __|  / _ \
 | |  | | | (_) | | | | | | |_  |  __/
 |_|  |_|  \___/  |_| |_|  \__|  \___|

Welcome to Monte, a tool to help you answer the question: 'When will the work be done?'


Please answer the following questions
How many tasks/tickets do you have left to complete? 40
Do you have a JIRA csv export to use? no
Enter the smallest number of tasks/tickets you have finished in a week? 2
Enter the largest number of tasks/tickets you have finished in a week? 6
When will you start work (e.g. 28/04/2021) 2020-11-21
How certain are you with regard to the scope of the work? high
How many simulations would you like to run? 10000
┌──────────────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
│Forecast Certainty│    5%    │   15%    │   30%    │   50%    │   70%    │   85%    │   95%    │
├──────────────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤
│  Forecast Date   │2021-02-06│2021-02-06│2021-02-13│2021-02-13│2021-02-20│2021-02-27│2021-03-06│
└──────────────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```

Forecasting like this works better when you use real data from the past to model
what the future will look like. To enable this Monte can use a JIRA export of
tasks completed over whatever historic timeframe you would like. Once you have
created your JQL filter ensure that you include the "Resolved" column and then
export as a csv. When running the app you will be given the option to specify
the path of the file and this will then build a distribution of previous
throughputs for use in the simulations. The following is a runthrough using a
test data file.

```sh
  __  __                   _
 |  \/  |   ___    _ __   | |_    ___
 | |\/| |  / _ \  | '_ \  | __|  / _ \
 | |  | | | (_) | | | | | | |_  |  __/
 |_|  |_|  \___/  |_| |_|  \__|  \___|

Welcome to Monte, a tool to help you answer the question: 'When will the work be done?'


Please answer the following questions
How many tasks/tickets do you have left to complete? 40
Do you have a JIRA csv export to use? Yes
what is the absolute file path to the csv file /Users/user/directory/monte/spec/test_data/data.csv
When will you start work (e.g. 28/04/2021) 2020-11-21
How certain are you with regard to the scope of the work? medium
How many simulations would you like to run? 10000
┌──────────────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
│Forecast Certainty│    5%    │   15%    │   30%    │   50%    │   70%    │   85%    │   95%    │
├──────────────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤
│  Forecast Date   │2021-02-06│2021-02-13│2021-02-20│2021-03-06│2021-03-13│2021-03-27│2021-04-10│
└──────────────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Copyright

Copyright (c) 2020 Andrew Werner. See [MIT License](LICENSE.txt) for further details.
