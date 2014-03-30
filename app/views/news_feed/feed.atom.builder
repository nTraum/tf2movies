atom_feed :language => 'en-US' do |feed|
  feed.title    @title
  feed.subtitle 'TF2 movies published on TF2Movies'
  feed.updated  @updated

  @movies.each do |movie|
    feed.entry(movie) do |entry|
      entry.title   movie.title
      entry.updated movie.updated_at.iso8601
      entry.content(render(:partial => 'shared/embedded_html5', :locals => {:movie => movie}, :formats => [:html]), :type => 'html')

      entry.summary(truncate(movie.description, :length => 100, :seperator => ' '))
      entry.category(:term => movie.game_mode.name) if movie.game_mode
      entry.category(:term => movie.tf2_class.name) if movie.tf2_class
      entry.category(:term => movie.region.name) if movie.region

      entry.author do |author|
        author.name movie.author.nickname
        author.uri(author_url movie.author)
      end
    end
  end
end