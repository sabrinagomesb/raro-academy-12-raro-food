require "sidekiq"
require "sidekiq/web"

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  # [user, password] == ["rarofood", "rarofood@r@r02023"]
  [user, password] == [ENV["SIDEKIQ_USERNAME"], ENV["SIDEKIQ_PASSWORD"]]
end
