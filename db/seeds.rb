# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TF2_CLASSES = %w(Scout Soldier Pyro Demoman Heavy Engineer Medic Sniper Spy Mixed)
GAME_MODES  = %w(6v6 Highlander Jump BBall Mixed)
REGIONS     = ["Europe", "South America", "North America", "Asia", "Africa", "Oceania", "Global"]

unless Tf2Class.any?
  Rails.logger.info("Seeding TF2 classes...")
  TF2_CLASSES.each do |tf2_class|
    Tf2Class.create(name: tf2_class)
    Rails.logger.info("#{tf2_class} created.")
  end
end

unless GameMode.any?
  Rails.logger.info("Seeding game modes...")
  GAME_MODES.each  do |game_mode|
    GameMode.create(name: game_mode)
    Rails.logger.info("#{game_mode} created.")
  end
  Rails.logger.info("Seeding of game modes completed.")
end

unless Region.any?
  Rails.logger.info("Seeding regions...")
  REGIONS.each do |region|
    Region.create(name: region)
    Rails.logger.info("#{region} created.")
  end
end
