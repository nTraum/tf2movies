namespace :tf2movies do
  desc "Refreshs movie meta data"
  task refresh_movies: :environment do
    movie = Movie.order(:info_refreshed_at).first
    YoutubeInfoProvider.update_movie!(movie) if movie
  end

  desc "Checks and refreshs the availability of downloads"
  task refresh_downloads: :environment do
    download = Download.where(status_refreshed_at: nil).first || Download.order(:status_refreshed_at).first
    DownloadChecker.check_status!(download) if download
  end

  desc "Let a user become an admin"
  task :adminify, [:nickname] => :environment do |_t, args|
    if args.nickname && args.nickname.present?
      admin_to_be = User.find_by(nickname: args.nickname)
      if admin_to_be
        admin_to_be.admin!
        admin_to_be.save!
        puts "User #{args.nickname} is now an admin.".green
      else
        puts "Could not find user '#{args.nickname}'.".red
      end
    else
      puts 'No user name specified, don\'t know who should become an admin.'.red
      puts "Invoke this task with an argument, e.g. rake tf2movies:adminify[foo]".red
    end
  end
end
