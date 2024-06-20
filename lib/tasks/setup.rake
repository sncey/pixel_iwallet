namespace :db do
  desc 'Setup database and fetch users'
  task setup: [:environment, :create, 'json_placeholder:fetch_users', :migrate, :seed]
end