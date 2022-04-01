# frozen_string_literal: true
require_relative 'boot'
# require 'rails/all'
require "rails"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_job/railtie"
require "action_cable/engine"
require "action_mailbox/engine"
require "action_text/engine"
# require "rails/test_unit/railtie"
# require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Base
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.load_defaults "7.0"
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.active_record.default_timezone = :local
    config.time_zone = 'America/Recife'
    #Se for trabalhar com time zones para não ter problemas e rapidamente irá decorar quais métodos devem ou não ser usados.
    # Não use
    #  Time.now # => Retorna o horário do sistema e ignora a time zone do projeto.
    #  Time.parse("2012-03-02 16:05:37") # => Irá assumir que a string recebida tá na time zone do sistema.
    #  Time.strptime(time_string, '%Y-%m-%dT%H:%M:%S%z') # Mesmo problema do Time.parse.
    #  Date.today # Pode ser ontem ou amanhã de acordo com a time zona setada na máquina.
    #  Date.today.to_time # => # Também não segue a time zone do projeto.
    # Use
    #  2.hours.ago # => Fri, 02 Mar 2012 20:04:47 UTC -03:00
    #  1.day.from_now # => Fri, 03 Mar 2012 22:04:47 UTC -03:00
    #  Date.today.to_time_in_current_zone # => Fri, 02 Mar 2012 22:04:47 UTC -03:00
    #  Date.current # => Fri, 02 Mar
    #  Time.zone.parse("2012-03-02 16:05:37") # => Fri, 02 Mar 2012 16:05:37 UTC -03:00
    #  Time.zone.now # => Fri, 02 Mar 2012 22:04:47 UTC -03:00
    #  Time.current # Mesma coisa, só que de forma mais curta.
    #  Time.zone.today # Se você não pode usar Time ou DateTime.
    #  Time.zone.now.utc.iso8601 # Quando for trabalhar com APIs.
    #  Time.strptime(time_string, '%Y-%m-%dT%H:%M:%S%z').in_time_zone(Time.zone) # Se não pode usar Time.pars

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'pt-BR'

    # Turbo supersedes the functionality offered by Rails UJS to turn links and form submissions into XMLHttpRequests,
    # so if you're making a complete switch from Rails UJS / Turbolinks to Turbo, you should ensure that you have
    config.action_view.form_with_generates_remote_forms = false

    # config.autoload_paths << Rails.root.join('lib/autoload')
    # config.eager_load_paths << Rails.root.join('lib/autoload')
    # Command if you want ignore specific folder
    # Rails.autoloaders.main.ignore("#{config.root}/lib/templates")

    config.active_record.schema_format = :sql
    
    ActiveModelSerializers.config.embed = :ids

    config.generators do |g|
      g.scaffold_controller :my_scaffold_controller
      g.template_engine nil
      g.helper nil
      g.test_framework  :rspec, request_specs: false
      g.stylesheets  false
      g.javascripts  false
    end
    
    config.action_dispatch.rescue_responses.merge!(
      'AuthorizationException' => :unauthorized
    )
  end
end
