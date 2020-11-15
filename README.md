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
>
>   __  __                   _
>  |  \/  |   ___    _ __   | |_    ___
>  | |\/| |  / _ \  | '_ \  | __|  / _ \
>  | |  | | | (_) | | | | | | |_  |  __/
>  |_|  |_|  \___/  |_| |_|  \__|  \___|
>
> Please answer the following:
>
> How many items do you have in your backlog? 40
> How certain are you with regard to the scope of the work? medium
> When will you start work (e.g. 28/04/2021) 2020-11-15
> What is the smallest number of tasks/tickets you have completed in a week? 2
> What is the largest number of tasks/tickets you have completed in a week? 6
> How many simulations would you like to run 10000
>
>
> Your Results
>
> ┌──────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
> │    5%    │   15%    │   30%    │   50%    │   70%    │   85%    │   95%    │
> ├──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤
> │2021-02-14│2021-02-21│2021-02-28│2021-02-28│2021-03-07│2021-03-14│2021-03-21│
> └──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
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
