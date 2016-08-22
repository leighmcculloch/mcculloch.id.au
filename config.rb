set :css_dir, "stylesheets"

configure :production do
  activate :minify_html
  activate :minify_css
  activate :asset_hash
end
