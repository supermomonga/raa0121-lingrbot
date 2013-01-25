# -*- coding : utf-8 -*-
require 'json'
BCDicePATH = "BCDice"
GAMELIST = JSON.parse File.read("gameList.json")

get '/dice' do
  'lingr:DiceBot'
end

post '/dice' do
  content_type :text
  json = JSON.parse(request.body.string)
  game_type = '""'

  json["events"].select {|e|
    e["message"]
  }.map {|e|
    command = e["message"]["text"].strip.split(/[\s　]/)
    dice_command = command[0].gsub(">","\\>").gsub("<","\\<").gsub("(","\\(").gsub(")","\\)").gsub("=","\\=")
    game_type = GAMELIST.fetch(command[1], '""')
    [`cd #{BCDicePATH}; ruby customDiceBot.rb #{dice_command} #{game_type}`,
     e["message"]["nickname"]]
  }.reject {|result, u|
    result == "\n"
  }.map {|result, u|
    "#{u} : #{result.gsub("\n","")}"
  }.join
end
