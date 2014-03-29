class YoutubeInfoProvider
  def self.update_movie(movie, youtube_id_or_url)
    begin
      movie_info = youtube_client.video_by(youtube_id_or_url || movie.youtube_id)

      movie.youtube_id          = movie_info.unique_id
      movie.title               = movie_info.title
      movie.description         = movie_info.description
      movie.views               = movie_info.view_count
      movie.duration            = movie_info.duration
      movie.uploaded_on_youtube = movie_info.uploaded_at

      if movie.new_record?
        author_info = author_info_from_movie(movie_info)
        movie.author = Author.find_by(:youtube_id => author_info.user_id) ||
          Author.create!(
            :youtube_id  => author_info.user_id,
            :nickname    => author_info.username,
            :profile_url => "http://youtube.com/user/#{author_info.username}",
            :avatar_url  => author_info.avatar,
          )
      end

      movie.info_refreshed_at = DateTime.now
    rescue OpenURI::HTTPError
      movie.errors.add(:base, 'No YouTube movie found')
    end
  end

  def self.update_movie!(movie)
    update_movie(movie, nil)
    movie.save!
  end

  private

  def self.author_info_from_movie(movie_info)
    author_name = movie_info.author.uri.split('/').last #YOLO
    youtube_client.profile(author_name)
  end

  def self.youtube_client
    @@youtube_client ||= YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_API_KEY'])
  end

end