###
# Blog settings
###

# Time.zone = "UTC"

activate :directory_indexes
activate :livereload
activate :syntax

set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true, :smartypants => true

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths

  blog.prefix = "/"
  blog.permalink = ":year/:month/:day/:title/index.html"
  # Matcher for blog source files
  blog.sources = "posts/:year-:month-:day-:title.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "post"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"

  blog.tag_template = "tag.html"
  #blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 4
  blog.page_link = "page/{num}"
end

page "/atom.xml", layout: false
page "/sitemap.xml", :layout => false

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

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :partials_dir, 'partials'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

case ENV['TARGET'].to_s.downcase
when 'production'
  activate :deploy do |deploy|
    deploy.build_before = true
    deploy.method = :rsync
    deploy.host   = "lolindrath.com"
    deploy.path   = "/var/www/blog"
  end
else
  activate :deploy do |deploy|
    deploy.build_before = true
    deploy.method = :rsync
    deploy.host   = "lolindrath.com"
    deploy.path   = "/var/www/staging-blog"
  end
end
