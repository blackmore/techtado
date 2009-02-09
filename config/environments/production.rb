# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Enable threaded mode
# config.threadsafe!

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false #change to false
config.action_controller.perform_caching             = true


#config.action_view.debug_rjs                         = true #remove later 

# ----- MY MAIL CONF ------#
config.action_mailer.raise_delivery_errors = true
config.action_mailer.delivery_method = :smtp
config.action_mailer.default_content_type = "text/html"
config.action_mailer.default_url_options = { :host => "1und1.com" }
config.action_mailer.smtp_settings = {
    :tls              => true,
    :address          => "smtp.1und1.com",
    :port             =>  587,
    :domain           => "1und1.com",
    :authentication   => :plain,
    :user_name        => "pt7984266-1",
    :password         => "sabine"
  }
# ----- ############ ------#

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

