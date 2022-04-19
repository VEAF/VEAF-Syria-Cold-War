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

	missionCommands.addCommand(_name, customMission.rootMenu, customMissionReport, _code)

end


-- Display Mission Status

function customMissionReport(_code)

	message = "Mission Report\n" .. "-------------------------------------\n" .. "\n" .. string.format("Mission: %s\n", customMission.missions[_code].name) .. string.format("%s\n", customMission.missions[_code].description) .. "\n" .. string.format("Progress: %d / %d\n", customMission.missions[_code].progress, customMission.missions[_code].maxSteps)

	if customMission.missions[_code].progress < customMission.missions[_code].maxSteps then

		message = message .. "\n" .. string.format("Current task: %s", customMission.missions[_code].steps[customMission.missions[_code].progress+1].waypoint)

	else
	
		message = message .. "\n" .. "Mission is finished !"
		
	end

    trigger.action.outText(message,10)

end

function markStepDone(_code)

	message = "Congratulations !\n" .. "\n" .. string.format("Task: %s done\n", customMission.missions[_code].steps[customMission.missions[_code].progress+1].waypoint)
	--message = "Congratulations !\n" .. "\n" .. string.format("Task: %d done\n", customMission.missions[_code].progress)

	customMission.missions[_code].progress = customMission.missions[_code].progress + 1

	if customMission.missions[_code].progress < customMission.missions[_code].maxSteps then

		message = message .. "\n" .. string.format("New task: %s", customMission.missions[_code].steps[customMission.missions[_code].progress+1].waypoint)

	else 

		message = message .. "\n" .. string.format("Mission %s finished !", customMission.missions[_code].name)
	
	end

    trigger.action.outText(message,15)

end


customMission.init()
customMission.addMission("redChypre01", "Chypre 01", "Destroy roadblocks between Nicosia and Thermia,\ncapture Pinarbashi airport and neutralize Thermia FARP",
	{
		{
			waypoint = "Roadblock 01 (Chypre)",
		},
		{
			waypoint = "Pinarbashi Airport",
		},
		{
			waypoint = "Roadblock 02 (Chypre)",
		},
		{
			waypoint = "FARP Thermia",
		},
	}
)
