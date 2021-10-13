class Types::GameLevelsType < Types::BaseEnum
  description "Available game levels"

  Game::LEVELS.each do |level, settings|
    value level, "#{level.to_s.capitalize} level: #{settings[:rows]}x#{settings[:cols]} with #{settings[:mines]} mines"
  end
end
