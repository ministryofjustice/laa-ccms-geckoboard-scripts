require 'geckoboard'
require 'faraday'

api_key = ENV['GECKOBOARD_API_KEY']
sentry_api_key = ENV['SENTRY_API_KEY']

pda_url = 'https://sentry.service.dsd.io/api/0/projects/mojds/ProviderDeets/issues/'
pda_resp = Faraday.get(pda_url, {statsPeriod: '24h', query: 'environment:production'}, {'Authorization' => "Bearer #{sentry_api_key}"})
pda_hits = pda_resp.headers['X-Hits'].to_i

pui_url = 'https://sentry.service.dsd.io/api/0/projects/mojds/pui/issues/'
pui_resp = Faraday.get(pui_url, {statsPeriod: '24h', query: 'environment:production'}, {'Authorization' => "Bearer #{sentry_api_key}"})
pui_hits = pui_resp.headers['X-Hits'].to_i

connector_url = 'https://sentry.service.dsd.io/api/0/projects/mojds/connector/issues/'
connector_resp = Faraday.get(connector_url, {statsPeriod: '24h', query: 'environment:production'}, {'Authorization' => "Bearer #{sentry_api_key}"})
connector_hits = connector_resp.headers['X-Hits'].to_i

client = Geckoboard.client(api_key)

dataset = client.datasets.find_or_create('ccms.sentry.issues', fields: [
  Geckoboard::StringField.new(:project_name, name: 'Project'),
  Geckoboard::NumberField.new(:number_of_issues, name: 'Number of Issues', optional: false),
])

dataset.put([
  {
    project_name: 'Provider Details API',
    number_of_issues: pda_hits,
  },
  {
    project_name: 'PUI',
    number_of_issues: pui_hits,
  },
  {
      project_name: 'Connector',
      number_of_issues: connector_hits,
    }
])
