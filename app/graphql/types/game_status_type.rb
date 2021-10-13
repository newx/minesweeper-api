class Types::GameStatusType < Types::BaseEnum
  description "Game statuses"

  Game.statuses.each do |status, _value|
    value status, status.to_s.capitalize
  end
end
