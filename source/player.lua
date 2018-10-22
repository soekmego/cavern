player = {}

player.state = 1  -- 0 (cutscene), 1 (free to move)

player.width = 80
player.height = 192

player.physics = world:newBSGRectangleCollider(1000, 600, player.width,
  player.height, 22)
player.physics:setCollisionClass('Player')
player.physics:setLinearDamping(2)
player.physics:setFixedRotation(true)
player.moveForce = 45000
player.maxSpeed = 500

player.health = gameState.player.maxHealth
player.damaged = 0 -- timer for the damage flash
player.faded = -1 -- determines if player is translucent for damage flash
player.fadedTimer = 0 -- timer for flipping faded status
player.barTimer = 0 -- timer for displaying the player's health bar

player.weapon = 0 -- 0 (none), 1 (blaster), 2 (rocket), 3 (harpoon)
--player.shotCooldown = 0 -- timer for pause between weapon shots
player.shotCooldown = {} -- Table that keeps track of all weapon cooldowns

player.armAngle = 0 -- Only used for calculating weapon direction

-- Initialize the shotCooldowns
for itr=0, 3 do
  player.shotCooldown[itr] = 0
end

player.submerged = false -- true if the player is underwater
player.drowning = false -- true if the player is drowning
player.facing = 1 -- 1 = right, -1 = left

player.jetpackTimer = 0
player.stateTimer = 0
player.drownTimer = 3

function player:update(dt)

  -- Player movement

  -- speedFromVelocity is from global_functions.lua
  -- takes vx and vy from getLinearVelocity and applies Pythagorean Theorem
  local speed = speedFromVelocity( self.physics:getLinearVelocity() )

  -- only apply force to the player if he is moving slower than the max speed
  if speed < self.maxSpeed and self.state == 1 then

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
      self.physics:applyForce(0, self.moveForce)
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
      self.physics:applyForce(0, -1 * self.moveForce)
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
      self.physics:applyForce(-1 * self.moveForce, 0)
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
      self.physics:applyForce(self.moveForce, 0)
    end

  end

  -- State timer
  self.stateTimer = updateTimer(self.stateTimer, dt)

  -- Healthbar timer
  self.barTimer = updateTimer(self.barTimer, dt)

  -- Drowning timer
  if self.drowning then
    self.drownTimer = updateTimer(self.drownTimer, dt)
  end
  if self.drownTimer <= 0 then
    self.drowning = false
    self.drownTimer = 3
    self.health = 0
  end

  -- Handle damage flash timers
  self.damaged = updateTimer(self.damaged, dt)
  self.fadedTimer = updateTimer(self.fadedTimer, dt)

  -- Update shot cooldown timer
  --self.shotCooldown = updateTimer(self.shotCooldown, dt)

  -- Update all cooldown timers (index 1, 2, and 3)
  for itr=1, 3 do
    self.shotCooldown[itr] = updateTimer(self.shotCooldown[itr], dt)
  end

  if love.mouse.isDown(1) and self.shotCooldown[self.weapon] <= 0 and self.state == 1 then
    player:shoot()
  end

  -- Handles all collisions for the player
  player:collisions(dt)

  -- This section handles the player interacting with Water
  local px, py = self.physics:getPosition()
  local waters = world:queryCircleArea(px, py, 40, {'Water'})
  local ripples = world:queryCircleArea(px, py, 40, {'Ripple'})
  if #ripples > 0 and #waters == 0 then

    player.submerged = false

    -- Stop drowning (if they were)
    if gameState.pickups.aquaPack == false and blackScreen.alpha == blackScreen.fullRedAlpha then
      blackScreen:removeRed()
      self.drowning = false
    end

  elseif #ripples > 0 and #waters > 0 then

    player.submerged = true

    -- Drown if the player does not have the aquaPack
    if gameState.pickups.aquaPack == false and blackScreen.red == false then
      blackScreen:setRed()
      self.drowning = true
      self.drownTimer = 3 -- 3 seconds until death!
    end

  end

  -- "facing" is used for drawing the player sprites
  -- flip to the side of the player the mouse is at
  local mx, my = cam:mousePosition()
  if mx < px then
    player.facing = -1
  else
    player.facing = 1
  end

  if player.damaged > 0 then
    if player.fadedTimer <= 0 then
      player.fadedTimer = 0.04
      player.faded = player.faded * -1
    end
  else
    player.faded = 1
  end

  -- Triggers the tutorial message to disappear
  if gameState.tutorial and px > 1664 then
    tutorial.active = false
  end

  -- Update jetpack timer (for spawning fire particles)
  self.jetpackTimer = updateTimer(self.jetpackTimer, dt)

  if self.jetpackTimer <= 0 and player.submerged == false then
    fires:spawnFire(px + (self.facing * -44), py + 50, 0.2, vector(0, 1))
  end

  -- Player death
  if player.health <= 0 and player.state > 0 then

    local px, py = player.physics:getPosition()

    player.state = -1 -- freeze the player
    spawnBlast(px, py, 600, {0.5, 0.5, 0.5}, 1)

    -- When the player dies, he doesn't get destroyed, he is just moved outside
    -- the room where he can't be seen.
    player.physics:setPosition(px, -300)

    -- When this timer hits zero, start the fadeout
    player.stateTimer = 2

    -- Remove red if the player just drowned
    if blackScreen.red then
      blackScreen:removeRed()
    end

  end

  -- Player has died, need to fadeout the screen
  if self.stateTimer < 0 and self.state == -1 then
    blackScreen:fadeOut(1)
    self.stateTimer = 1.5
    self.state = -2
  end

  -- Fadeout completed, load the save file
  if self.stateTimer < 0 and self.state == -2 then
    loadGame()
  end

  -- At the end of the game, there is a section where the player is going down
  -- to the final boss, and the room gets darker. This code sets the darkness
  -- based on the player's position in the room.
  if gameState.room == "rm28" then
    local px, py = player.physics:getPosition()
    if py < 1400 then
      blackScreen.alpha = 0
    else
      blackScreen.alpha = (py - 1400) / 2300
    end
  end

  -- Prevent the player from flying up past the final boss
  if gameState.room == "rmBoss" and player.health > 0 then
    local px, py = player.physics:getPosition()
    if py < 600 then
      player.physics:setY(600)
    end
  end

  -- Freeze the player offscreen if at the main menu
  if gameState.room == "rmMainMenu" then
    player.state = 0
    player.physics:setPosition(-500, -500)
  end

  -- Perform the slow fly-down after the intro
  if self.state == -10 then

    local px, py = player.physics:getPosition()
    player.physics:setY(py + (128 * dt))

    if py > 1080 then
      self.state = -11
      self.stateTimer = 3
      self.physics:applyLinearImpulse(0, 5000)
      saveGame()

      -- After saving the first time, spawn a new save block
      -- (it's the one in this same starting room)
      saveUtil:spawnSave(2816, 1)
    end

  end

  -- Pause, then show the tutorial message
  if self.state == -11 and self.stateTimer == 0 then
    --textBox:start("tutorial")
    tutorial:start()
    self.state = 1
  end

end

-- Draw the player
function player:draw()

  if player.faded == -1 then
    love.graphics.setColor(1, 1, 1, 0.784) -- damage flash
  else
    love.graphics.setColor(1, 1, 1, 1)
  end

  local px, py = self.physics:getPosition()

  -- Determine arm data
  local armSprite = sprites.player.armEmpty -- sprite to draw for the arm
  local moveX = -15 -- position in X direction
  local moveY = -16 -- position in Y direction
  local ox = 19 -- offset x
  local oy = 16 -- offset y

  -- flip is used to decide if the sprite needs to flip vertically
  local flip = 1
  local mx, my = cam:mousePosition()
  if mx < px then
    flip = -1
  end

  -- point that determines the angle towards the mouse
  local armX = px
  local armY = py
  if player.weapon == 1 then
    armX = armX + (player.facing * -22)
    armY = armY - 12
  end

  --local vx, vy = (toPlayerVector(mx, my)*-1):unpack()
  local vx, vy = (toMouseVector(armX, armY)):unpack()
  local armAngle = math.atan2(vy, vx) -- angle that the arm will rotate
  debug = armAngle

  local headX = px
  local headY = py - 68
  vx, vy = (toMouseVector(headX, headY)):unpack()
  local headAngle = math.atan2(vy, vx) -- angle that the head will rotate
  debug2 = headAngle

  -- Don't want head looking straight up or straight down, want to limit
  -- this angle
  if flip == 1 then
    if headAngle < -0.7 then
      headAngle = -0.7
    elseif headAngle > 0.7 then
      headAngle = 0.7
    end
  else
    if headAngle < 0 and headAngle > -2.4 then
      headAngle = -2.4
    elseif headAngle > 0 and headAngle < 2.6 then
      headAngle = 2.6
    end
  end

  -- Keeps the left-side angles negative
  if headAngle > 2 then
    headAngle = -1 * math.pi - (math.pi - headAngle)
  end

  -- Jetpack data
  local jetSprite = sprites.player.jetpack
  if gameState.pickups.aquaPack then
    jetSprite = sprites.player.aquaPack
  end

  -- Draw one arm behind the player
  if player.weapon == 1 then
    love.graphics.draw(sprites.player.backArm, px + (6 * player.facing), py + moveY, armAngle, 1, flip, 14, 10)
  end

  -- draw jetpack first
  love.graphics.draw(jetSprite, px + (player.facing * -22), py + 10, nil, player.facing, 1, 38, 60)
  -- body uses player.facing to turn the correct direction (towards the mouse)
  love.graphics.draw(sprites.player.body, px + (player.facing * -14), py+8, nil, player.facing, 1, 38, 60)
  -- helmet rotates towards the mouse, flips vertically if facing left
  love.graphics.draw(sprites.player.helmet, px + (player.facing * 2), py-44, headAngle, 1, flip, 24, 64)

  -- Draw arms / weapons
  if player.weapon == 0 then

    armAngle = headAngle
    if armAngle < -1.5 then
      -- Fixes the angle when facing left
      armAngle = armAngle + 3
    end
    love.graphics.draw(armSprite, px + (moveX * player.facing), py + moveY, armAngle/3, flip, 1, ox, oy)

  elseif player.weapon == 1 then

    armSprite = sprites.player.armBlaster
    moveX = -18
    moveY = -20
    ox = 8
    oy = 20

  elseif player.weapon == 2 then

    armSprite = sprites.player.armRocket
    ox = 16
    oy = 42
    moveX = -17
    moveY = -11

  elseif player.weapon == 3 then

    -- If the weapon can fire, show the loaded sprite
    if self.shotCooldown[self.weapon] == 0 then
      armSprite = sprites.player.armSpearLoaded
    else
      armSprite = sprites.player.armSpear
    end
    ox = 16
    oy = 12
    moveX = -12
    moveY = -18
    
  end

  if player.weapon > 0 then
    love.graphics.draw(armSprite, px + (moveX * player.facing), py + moveY, armAngle, 1, flip, ox, oy)
  end

  player.armAngle = armAngle

end

function player:drawHealth()

  local px, py = self.physics:getPosition()
  local mx, my = cam:mousePosition()

  -- Draw player's healthbar only if the player has been damaged recently
  -- or if the mouse is overtop (or close to overtop) the player
  -- Don't draw anything if the player has no health left
  if (player.barTimer > 0 or distance(px, py, mx, my) < 100) and player.health > 0 then

    local multi = 4 -- multiplier to increase the size of the healthbar
    local barWidth = gameState.player.maxHealth * multi

    -- Draw the back of the bar (the red part)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", px - barWidth/2, py - 124, barWidth, 16)

    -- Draw the front of the bar (the green part)
    local greenWidth = player.health / gameState.player.maxHealth * barWidth
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle("fill", px - barWidth/2, py - 124, greenWidth, 16)

  end

end

-- Player shoots his equipped weapon
function player:shoot()
  -- Don't spawn anything if the player doesn't have a weapon
  if self.weapon == 0 then
    return nil
  end

  -- Can't shoot the blaster or rocket launcher if underwater
  if (self.weapon == 1 or self.weapon == 2) and self.submerged then
    -- put an "error" sound effect here
    return nil
  end

  self.shotCooldown[self.weapon] = 0 -- amount of time (in seconds) between each shot

  if self.weapon == 1 then -- Blaster
    self.shotCooldown[self.weapon] = 0.5
  elseif self.weapon == 2 then -- Rocket
    self.shotCooldown[self.weapon] = 3
  elseif self.weapon == 3 then -- Harpoon
    self.shotCooldown[self.weapon] = 1
  end

  local px, py = self.physics:getPosition()
  spawnWeapon(px, py)
end

-- Cycle between each weapon
function player:swapWeapon()

  -- Order is Blaster, then Rocket, then Harpoon, then back to Blaster
  if player.weapon == 1 and gameState.pickups.rocket then
    player.weapon = 2
  elseif player.weapon == 2 then
    if gameState.pickups.harpoon then
      player.weapon = 3
    else
      player.weapon = 1
    end
  elseif player.weapon == 3 then
    player.weapon = 1
  end

end

-- Player takes damage
function player:hurt(damage)
  damage = damage + math.random(0, 1)
  if self.damaged == 0 then
    self.damaged = 1
    self.health = self.health - damage
    damages:spawnDamage(self.physics:getX(), self.physics:getY(), damage)
    shake:start(0.05, 6, 0.01, 0.3)
    player.barTimer = 3 -- healthbar is visibile for 3 seconds
    soundManager:play("playerHurt")
  end
end

-- Called in player:update, handles all collisions
function player:collisions(dt)

  if self.physics:enter('Transition') then
    local t = self.physics:getEnterCollisionData('Transition')
    -- Change to the map (stored in the transition's name), and pass t.collider
    -- Note: t.collider is just the transition object
    changeToMap(t.collider.toMap, t.collider)
  end

end
