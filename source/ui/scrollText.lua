-- Scroll handles all text that shows text letter-by-letter

scroll = {}

scroll.text = ""         -- Text currently on screen
scroll.fullMessage = ""  -- Full message that will be displayed
scroll.messageObj = nil  -- Message object pulled from messages.lua
scroll.charTimer = 0     -- Timer until next letter is displayed
scroll.textSpeed = 0.05   -- Display a new character every 0.2 seconds
scroll.messageNum = 1    -- Which string from the message object
scroll.charNum = 0       -- Which character of the full message we're on

function scroll:showMessage(m)

  -- Freezes everything (mostly)
  gameState.state = 0

  -- Sets the first set of text for the message
  self.fullMessage = messages[m][1]
  self.text = ""

  self.messageNum = 1
  self.charNum = 0
  self.messageObj = messages[m]

  -- The messages table contains other tables, each containing a set of strings
  -- which will be displayed in order to the text window.




end

function scroll:update(dt)

  if self.messageObj ~= nil then
    while self.messageNum <= #self.messageObj do

      if self.fullMessage == "" then
        self.fullMessage = self.messageObj[self.messageNum]
      end

      if self.charNum < string.len(self.fullMessage) then
        self.charTimer = updateTimer(self.charTimer, dt)
        if self.charTimer == 0 then
          self.charNum = self.charNum + 1
          self.text = string.sub(self.fullMessage, 1, self.charNum)
          self.charTimer = self.textSpeed
        end
      else
        if love.keyboard.isDown("space","return") or love.mouse.isDown(1,2) then
          self.text = ""
          self.fullMessage = ""
          self.charNum = 0
          self.messageNum = self.messageNum + 1
        end
      end

      return
    end

    gameState.state = 1
    self.messageObj = nil

  end

end
