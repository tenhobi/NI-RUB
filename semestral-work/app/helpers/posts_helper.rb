module PostsHelper
  def add_links_to_description(text)
    raw(
      text.gsub(/#([a-zA-Z]\w+)/i){ embed_hashtag($1) }
    )
  end

  private

  def embed_hashtag(tag)
    link_to "##{tag}", Rails.application.routes.url_helpers.tag_filter_path(tag)
  end
end
