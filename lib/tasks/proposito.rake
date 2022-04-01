# ______                                _  _         ______  _         _  _          _ 
# | ___ \                              (_)| |        |  _  \(_)       (_)| |        | |
# | |_/ /_ __  ___   _ __    ___   ___  _ | |_  ___  | | | | _   __ _  _ | |_  __ _ | |
# |  __/| '__|/ _ \ | '_ \  / _ \ / __|| || __|/ _ \ | | | || | / _` || || __|/ _` || |
# | |   | |  | (_) || |_) || (_) |\__ \| || |_| (_) || |/ / | || (_| || || |_| (_| || |
# \_|   |_|   \___/ | .__/  \___/ |___/|_| \__|\___/ |___/  |_| \__, ||_| \__|\__,_||_|
#                   | |                                          __/ |                 
#                   |_|                                         |___/    

namespace :proposito do
	namespace :api do
		desc 'Creates an api key'
		task generate_key: :environment do
			api_key = ApiKey.create
			p api_key
		end
	end
	namespace :db do
		desc 'Initialize database project: rake proposito:db:init'
		task init: :environment do
			p '[DB:CREATE]'
			Rake::Task["db:create"].invoke
			p '[DB:MIGRATE]'
			Rake::Task["db:migrate"].invoke
			p '[DB:MIGRATE][ENV=TESTE]'
			Rake::Task["db:migrate"].invoke('RAILS_ENV=test')
			p '[DB:SEED]'
			Rake::Task["db:seed"].invoke
			# p '[DB:SEED][APP]'
			# Rake::Task["db:seed:app"].invoke
		end
		desc 'Recreate project database: rake proposito:db:reset'
		task reset: :environment do
			p '[DB:DROP]'
			Rake::Task["db:drop:_unsafe"].invoke
			p '[DB:INIT]'
			Rake::Task["proposito:db:init"].invoke
		end
	end
	namespace :deploy do
		desc 'Run pre deployment taks: rake proposito:deploy:pre'
		task pre: :environment do
			p '[DB:MIGRATE]'
			Rake::Task["db:migrate"].invoke
			p '[ASSETS:PRECOMPILE]'
			Rake::Task["assets:precompile"].invoke
		end
	end

end