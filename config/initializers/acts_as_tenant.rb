require 'acts_as_tenant/sidekiq'

ActsAsTenant.configure do |config|
    config.require_tenant = false # true if you want to raise an  ActsAsTenant::NoTenant error
end