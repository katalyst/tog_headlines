require_plugin 'tog_core'
require_plugin 'acts_as_taggable_on_steroids'
require_plugin 'seo_urls'

Tog::Plugins.settings :tog_headlines, "moderated_stories" => "true"
Tog::Plugins.settings :tog_headlines, 'pagination_size'   => "10"


require "i18n" unless defined?(I18n)
Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

Tog::Plugins.helpers Headlines::StoriesHelper

Tog::Interface.sections(:admin).add "News", "/admin/headlines/stories"
Tog::Interface.sections(:admin).tabs("News").add_item "Published", "/admin/headlines/stories/published"
Tog::Interface.sections(:admin).tabs("News").add_item "Drafts", "/admin/headlines/stories/draft"
Tog::Interface.sections(:admin).tabs("News").add_item "Archived", "/admin/headlines/stories/archived"

Tog::Search.sources << "Story"