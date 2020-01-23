# CCMS Geckoboard Scripts

Scripts to load data into [Geckoboard datasets](https://www.geckoboard.com/datasets/).

# Usage

First run `bundle install`

Define the following environment variables:

| Name               | Description                |
| ------------------ | ---------------------------|
| SENTRY_API_KEY     | The API key for Sentry     |
| GECKOBOARD_API_KEY | The API key for Geckoboard |

Then run `bundle exec ruby senty_to_geckoboard.rb`

## Licence
[MIT](LICENSE)