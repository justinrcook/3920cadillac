###
# Middleman Thumbnailer
###
require 'middleman-thumbnailer'
activate :thumbnailer,
  :dimensions => {
    :small => '200x150',
    :medium => '400x300'
  },
  :namespace_directory => %w(rooms)

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

#- http://stackoverflow.com/questions/14823169/pass-dynamic-content-to-template-in-middleman
data.house.rooms.each do |room|
  proxy "/rooms/#{room[:name]}.html", '/rooms/template.html',
  locals: { room: room }, ignore: true
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

set :css_dir,     'stylesheets'
set :js_dir,      'javascripts'
set :images_dir,  'images'
set :fonts_dir,   'fonts'
set :partials_dir, '/layouts/partials'

# Development Settings
configure :development do
  activate :dotenv, env: '.env.development'
  activate :google_analytics do |ga|
    ga.tracking_id = false
  end
end

# Build-specific configuration
configure :build do
  activate :dotenv, env: '.env.build'
  activate :google_analytics do |ga|
    ga.tracking_id = 'UA-47908424-1'
  end

  # Minify CSS and Javascript on build
  activate :minify_css
  activate :minify_javascript

  # Use assets cdn to host images, javascript and stylesheets
  activate :asset_host
  set :asset_host, "//assets.#{ENV['domain']}/"

  # Enable cache buster
  # activate :asset_hash
end

  # Deployment
  activate :deploy do |deploy|
    activate :dotenv, env: '.env.build'

    deploy.build_before = true
    deploy.method       = :sftp
    deploy.host         = ENV['domain']
    deploy.path         = ENV['deploy_path']
    deploy.user         = ENV['deploy_user']
    deploy.password     = ENV['deploy_password']
  end