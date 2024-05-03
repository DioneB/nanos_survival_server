Console.Log("Core Starting")


-- Spawn some props in the game world
local prop_table = Prop(Vector(200, 0, 0), Rotator(0, 0, 0), "nanos-world::SM_WoodenTable")
local prop_chair = Prop(Vector(400, 200, 0), Rotator(0, 0, 0), "nanos-world::SM_WoodenChair")
local prop_tire = Prop(Vector(600, 0, 0), Rotator(0, 0, 0), "nanos-world::SM_TireLarge")


-- Function to spawn a Character and possess it to a Player
function SpawnCharacter(player)
  -- Spawns a Character at position X=0, Y=0, Z=0 with default constructor parameters
  local new_character = Character(Vector(0, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Male")

  -- Possess the new Character
  player:Possess(new_character)
end

-- Subscribes to an Event which is triggered when Players join the server
-- (i.e. Player entity spawns)
Player.Subscribe("Spawn", SpawnCharacter)


-- When this Package loads, we don't have any Character spawned and possessed, so
-- iterates for all already connected Players and give them a Character as well.
-- This will make sure you also get a Character when you reload the package
Package.Subscribe("Load", function()
  for k, player in pairs(Player.GetAll()) do
    SpawnCharacter(player)
  end
end)


-- When Player leaves the server, destroy it's possessing Character
Player.Subscribe("Destroy", function(player)
  local character = player:GetControlledCharacter()
  if (character) then
    character:Destroy()
  end
end)
