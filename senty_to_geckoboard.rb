require 'geckoboard'
api_key = ENV['GECKOBOARD_API_KEY']

client = Geckoboard.client(api_key)

dataset = client.datasets.find_or_create('ccms.issues', fields: [
  Geckoboard::NumberField.new(:number_of_issues, name: 'Number of Issues', optional: false),
])

dataset.put([
  {
    number_of_issues: 2,
  }
])