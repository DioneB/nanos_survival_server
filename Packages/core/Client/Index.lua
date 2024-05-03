-- Traces at each 100ms
Timer.SetInterval(function()
  -- Gets the middle of the screen
  local viewport_2D_center = Viewport.GetViewportSize() / 2

  -- Deprojects to get the 3D Location for the middle of the screen
  local viewport_3D = Viewport.DeprojectScreenToWorld(viewport_2D_center)

  -- Makes a trace with the 3D Location and it's direction multiplied by 5000
  -- Meaning it will trace 5000 units in that direction
  local trace_max_distance = 5000

  local start_location = viewport_3D.Position
  local end_location = viewport_3D.Position + viewport_3D.Direction * trace_max_distance

  -- Determine at which object we will be tracing for (WorldStatic - StaticMeshes - and PhysicsBody - Props)
  local collision_trace = CollisionChannel.WorldStatic | CollisionChannel.PhysicsBody

  -- Sets the trace modes (we want it to return Entity and Draws a Debug line)
  local trace_mode = TraceMode.ReturnEntity | TraceMode.DrawDebug

  -- Last parameter as true means it will draw a Debug Line in the traced segment
  local trace_result = Trace.LineSingle(start_location, end_location, collision_trace, trace_mode)

  -- If hit something draws a Debug Point at the location
  if (trace_result.Success) then
    -- Makes the point Red or Green if hit an Actor
    local color = Color(1, 0, 0) -- Red

    if (trace_result.Entity) then
      color = Color(0, 1, 0) -- Green

      -- Here you can check which actor you hit like
      -- if (trace_result.Entity:GetType() == "Character") then ...
    end

    -- Draws a Debug Point at the Hit location for 5 seconds with size 10
    Debug.DrawPoint(trace_result.Location, color, 5, 10)
  end
end, 100)


local state = "Idle on Sandbox"
local details = "Developing Sandbox"
local large_text = "Core"
local large_image = "nanos-world-full-world"

-- Client.InitializeDiscord(client_id)

Client.SetDiscordActivity(state, details, large_image, large_text)
