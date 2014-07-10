include AutoHtml
class Lesson < ActiveRecord::Base
  belongs_to :group, counter_cache: true

  auto_html_for :external_url do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => true)
    # link :target => "_blank", :rel => "nofollow"
    # simple_format
  end
end
