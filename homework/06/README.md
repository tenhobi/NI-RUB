# Homework 6

Rates service that process converting of origin currency to target currency.

## Usage

`./rates [amount: number] [from: CC] [to: CC]`

Supported currency codes (CC): AUD, BRL, BGN, CNY, CZK, DKK, EUR, PHP, HKD, HRK, INR, IDR, ISK, ILS, JPY, ZAR, CAD, KRW, HUF, MYR, MXN, XDR, NOK, NZD, PLN, RON, RUB, SGD, SEK, CHF, THB, USD, GBP.

## How it works

The service downloads current (daily, if not present) exchange rates,
that are stored into home directory (into `~/.rates/`)
and reuse this data file.

## Documentation

Documentation supports YARD, which you can run as `yard` and then open `./doc/index.html`.

## Tests

Tests use [Minitest](https://github.com/seattlerb/minitest) and [Simplecov](https://github.com/simplecov-ruby/simplecov).

## Build

Build and install the gem.

````shell
gem build rates.gemspec
gem install rates-0.2.0.gem
````
