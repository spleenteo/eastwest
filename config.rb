# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes
activate :i18n, :mount_at_root => false
activate :livereload
# activate :syntax, :line_numbers => false
set :markdown_engine, :redcarpet
# set :markdown, :fenced_code_blocks => true, :smartypants => true
set :redcarpet, :with_toc_data => true
activate :directory_indexes


# Methods defined in the helpers block are available in templates
helpers do
  if environment == :build
    alias :old_link_to :link_to
    def link_to(name, path, options = {})
      target_path = path
      unless options[:relative] || path.start_with?('http')
        target_path = (http_prefix + path).gsub(/([^:])\/\//, '\1/')
      end
      old_link_to(name, target_path, options)
    end
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'
set :partials_dir, 'partials'


activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = true
  # Optional Settings
  # deploy.remote   = "custom-remote" # remote name or git url, default: origin
  # deploy.branch   = "custom-branch" # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Use relative URLs
  #activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/eastwest/"
end
