# Documentation here: http://guides.rubyonrails.org/asset_pipeline.html

Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w(welcome.css sessions.css)
