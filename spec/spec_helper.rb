ENV["OKCUPID_ENV"] = "test"

require_relative '../config/environment'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.color_enabled = true
  config.formatter = :documentation
  config.order = 'default'

  config.before do
    run_rake_task('db:migrate')
  end
end

def run_rake_task(task)
  RAKE_APP[task].invoke
  if task == 'db:migrate'
    RAKE_APP[task].reenable
  end
end
