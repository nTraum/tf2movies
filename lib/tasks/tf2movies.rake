namespace :tf2movies do

  desc 'Refreshs movie meta data'
  task refresh_movies: :environment do
    movie = Movie.order(:info_refreshed_at).first
    if movie
      movie.refresh_info
    end
  end

  desc 'Checks and refreshs the availability of downloads'
  task refresh_downloads: :environment do
    download = Download.where(:status_refreshed_at => nil).first || Download.order(:status_refreshed_at).first
    if download
      DownloadChecker.new(download).check_status
    end
  end

  desc 'Let a user become an admin'
  task :adminify, [:nickname] => :environment do |t, args|
    if args.nickname
      admin_to_be = User.find_by(:nickname => args.nickname)
      if admin_to_be
        admin_to_be.role = 'admin'
        admin_to_be.save!
        puts "User #{args.nickname} is now an admin.".green
      else
        puts "Could not find user '#{args.nickname}'.".red
      end
    else
      puts 'No user name specified, don\'t know who should become an admin.'.red
      puts 'Invoke this task with an argument, e.g. rake tf2movies:adminify[foo]'.red
    end
  end

  desc 'Checks tf2movies configuration'
  task check: :environment do
    puts 'Running tf2movies checks...'
    check_youtube_api_key
    check_steam_api_key
    check_secret_token
    check_sentry_raven_api_key
    puts 'Finished running checks.'
  end

  def check_youtube_api_key
    print 'Environment variable YOUTUBE_API_KEY exists?... '
    if ENV['YOUTUBE_API_KEY'].empty?
      puts 'no'.red
    else
      puts 'yes'.green
    end
  end

  def check_steam_api_key
    print 'Environment variable STEAM_API_KEY exists?... '
    if ENV['STEAM_API_KEY'].empty?
      puts 'no'.red
    else
      puts 'yes'.green
    end
  end

  def check_secret_token
    print 'Environment variable SECRET_TOKEN exists?... '
    if ENV['SECRET_TOKEN'].empty?
      puts 'no'.red
    else
      puts 'yes'.green
    end
  end

  def check_sentry_raven_api_key
    print 'Environment variable SENTRY_DSN exists?... '
    if ENV['SENTRY_DSN'].empty?
      puts 'no'.red
    else
      puts 'yes'.green
    end
  end
end