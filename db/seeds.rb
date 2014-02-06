# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Tf2Class.any?
  tf2_classes = %w[Scout Soldier Pyro Demoman Heavy Engineer Medic Sniper Spy]
  tf2_classes.each { |tf2_class| Tf2Class.create(:name => tf2_class) }
end

unless GameMode.any?
  game_modes = %w[6v6 Highlander Jump BBall]
  game_modes.each { |game_mode| GameMode.create(:name => game_mode) }
end