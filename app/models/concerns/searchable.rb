require 'cgi'

module Searchable
  extend ActiveSupport::Concern

  def google_search
    "http://google.com/search?q=#{CGI::escape search_pattern}"
  end

  def youtube_search
    "http://youtube.com/results?search_query=#{CGI::escape search_pattern}"
  end

  def soundcloud_search
    "http://soundcloud.com/search?q=#{CGI::escape search_pattern}"
  end
end