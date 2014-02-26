DBRegistry ||= OpenStruct.new(test: ConnectionAdapter.new("db/profiles-test.db"), 
  development: ConnectionAdapter.new("db/profiles-development.db"), 
  production: ConnectionAdapter.new("db/profiles-production.db")
)