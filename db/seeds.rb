# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Tf2Class.any?
  puts 'Seeding TF2 classes...'
  tf2_classes = %w[Scout Soldier Pyro Demoman Heavy Engineer Medic Sniper Spy]
  tf2_classes.each do |tf2_class|
    Tf2Class.create(:name => tf2_class)
    puts "\t...#{tf2_class}"
  end
  puts 'Seeding of TF2 classes completed.'
end

unless GameMode.any?
  puts 'Seeding game modes...'
  game_modes = %w[6v6 Highlander Jump BBall]
  game_modes.each  do |game_mode|
    GameMode.create(:name => game_mode)
    puts "\t...#{game_mode}"
  end
  puts 'Seeding of game modes completed.'
end

unless Region.any?
  puts 'Seeding regions...'
  regions = ['Europe', 'South America', 'North America', 'Asia', 'Africa', 'Oceania']
  regions.each do |region|
    Region.create(:name => region)
    puts "\t...#{region}"
  end
  puts 'Seeding of regions completed.'
end