function saveGame()
  gameState.player.x = player.physics:getX()
  gameState.player.y = player.physics:getY()
  local temp = Tserial.pack(gameState)
  love.filesystem.write("savefile.txt", temp)
end

function loadGame()
  if love.filesystem.exists("savefile.txt") then
    local temp = love.filesystem.read("savefile.txt")
    gameState = Tserial.unpack(temp, true)
  end
  player.physics:setPosition(gameState.player.x, gameState.player.y)
end