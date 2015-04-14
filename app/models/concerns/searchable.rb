require "cgi"

module Searchable
  extend ActiveSupport::Concern

  def google_search
    "http://google.com/search?q=#{escaped_search_pattern}"
  end

  def youtube_search
    "http://youtube.com/results?search_query=#{escaped_search_pattern}"
  end

  def soundcloud_search
    "http://soundcloud.com/search?q=#{escaped_search_pattern}"
  end

  private

  def escaped_search_pattern
    CGI::escape(search_pattern)
  end
end
