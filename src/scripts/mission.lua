-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mission Script Helper
-------------------------------------------------------------------------------------------------------------------------------------------------------------

customMission = {}
customMission.missions = {};

function customMission.init()

	customMission.rootMenu = missionCommands.addSubMenu('Missions')

end


function customMission.addMission(_code, _name, _description, _steps)

    customMission.missions[_code]={
	  name = _name,
	  description = _description,
	  progress = 0,
	  steps = _steps,
	  maxSteps = #(_steps),
	}

    for i,v in pairs(customMission.missions[_code].steps) do
      customMission.missions[_code].steps[i].done = false
    end

	missionCommands.addCommand(_name, customMission.rootMenu, customMissionReport, _code)

end


-- Display Mission Status

function customMissionReport(_code)

	local firstTodoStep = nil
	message = "Mission Report\n" .. "-------------------------------------\n" .. "\n" .. string.format("Mission: %s\n", customMission.missions[_code].name) .. string.format("%s\n", customMission.missions[_code].description) .. "\n" .. string.format("Progress: %d / %d\n", customMission.missions[_code].progress, customMission.missions[_code].maxSteps)

    for i,v in pairs(customMission.missions[_code].steps) do
  	  message = message .. "\n" .. string.format("- %s", customMission.missions[_code].steps[i].waypoint) .. ": "
	  if customMission.missions[_code].steps[i].done then
		message = message .. " done !"
	  else
		message = message .. " todo ..." 
		
		if firstTodoStep == nil then
			firstTodoStep = i
		end
	  end

    end

	if firstTodoStep ~= nil then

		message = message .. "\n\n" .. string.format("Current task: %s", customMission.missions[_code].steps[firstTodoStep].waypoint)

	else
	
		message = message .. "\n\n" .. "Mission is finished !"
		
	end

    trigger.action.outText(message,10)

end

function markStepDone(_code, _step)

	if not customMission.missions[_code].steps[_step].done then
	
		message = "Congratulations !\n" .. "\n" .. string.format("Task: %s done\n", customMission.missions[_code].steps[_step].waypoint)
		customMission.missions[_code].progress = customMission.missions[_code].progress + 1
		customMission.missions[_code].steps[_step].done = true
		trigger.action.outText(message,15)

		customMissionReport(_code)
	end

end

function isStepDone(_missionCode,_step)

   return customMission.missions[_missionCode].steps[_step].done == true
  
end

function isStepNotDone(_missionCode,_step)

	return isStepDone(_missionCode,_step) == false
  
end


customMission.init()
customMission.addMission("redChypre01", "Chypre 01", "Destroy roadblocks between Nicosia and Thermia,\ncapture Pinarbashi airport and neutralize Thermia FARP",
	{
		-- 1
		{
			waypoint = "Roadblock 01 (Chypre)",
		},
		-- 2
		{
			waypoint = "Pinarbashi Airport",
		},
		-- 3
		{
			waypoint = "Roadblock 02 (Chypre)",
		},
		-- 4
		{
			waypoint = "FARP Thermia",
		},
	}
)

customMission.addMission("redChypre02", "Chypre 02", "Destroy Radars and Fuel depots in VD96",
	{
		-- 1
		{
			waypoint = "Drop RED troops on VD96",
		},
		-- 2
		{
			waypoint = "Destroy RADARS on VD86 (South site)",
		},
		-- 3
		{
			waypoint = "Destroy the RADAR on VD86 (North site)",
		},
		-- 4
		{
			waypoint = "Destroy Fuel depots on VD86 (North site)",
		},
	}
)

customMission.addMission("redShayrat", "Shayrat", "Destroy Shayrat Warehouses and capture the airport,\nthen, defend from enemy CAP",
	{
		-- 1
		{
			waypoint = "Destroy Shayrat Wharehouses",
		},
		-- 2
		{
			waypoint = "Capture Shayrat airport (allied convoy ETA 8 minutes)",
		},
		-- 3
		{
			waypoint = "Destroy incoming Air strike (from south)",
		},
	}
)
