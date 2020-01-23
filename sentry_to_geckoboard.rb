require 'geckoboard'
require 'faraday'

api_key = ENV['GECKOBOARD_API_KEY']
sentry_api_key = ENV['SENTRY_API_KEY']

url = 'https://sentry.service.dsd.io/api/0/projects/mojds/ProviderDeets/issues/'
resp = Faraday.get(url, {statsPeriod: '24h'}, {'Authorization' => "Bearer #{sentry_api_key}"})
hits = resp.headers['X-Hits'].to_i

client = Geckoboard.client(api_key)

dataset = client.datasets.find_or_create('ccms.issues', fields: [
  Geckoboard::NumberField.new(:number_of_issues, name: 'Number of Issues', optional: false),
])

dataset.put([
  {
    number_of_issues: hits,
  }
])