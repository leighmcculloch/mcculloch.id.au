compass_config do |config|
  config.output_style = :compact
end

configure :development do
  activate :livereload
end

set :css_dir, 'stylesheets'

configure :build do
  activate :minify_html
  activate :minify_css
  activate :gzip
  activate :asset_hash
  activate :relative_assets
end

# Sync with AWS S3
activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'mcchouse.com'
  s3_sync.region                     = 'us-east-1'
  s3_sync.delete                     = true
  s3_sync.after_build                = true
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = true
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.version_bucket             = false
end

activate :cdn do |cdn|
  cdn.cloudflare = {
    zone: 'mcchouse.com',
    base_urls: ['http://mcchouse.com']
  }
  cdn.filter = /\.html$/
  cdn.after_build = true
end
