local ZoneQuestTracker = CreateFrame("Frame")

local function debugZoneAPIs()
    local realZoneText = GetRealZoneText()
    local subZoneText = GetSubZoneText()
    local zoneText = GetZoneText()

    print("Current player map ID: " .. C_Map.GetBestMapForUnit("player"))
    print("Real Zone name: " .. realZoneText .. "") -- i.e Thaldrazus
    print("Sub zone name: " .. subZoneText .. "") -- i.e The petitioner's course
    print("Zone name: " .. zoneText .. "") -- i.e thaldrazus
end

local function debugQuestAPIs()
    for i = 1, C_QuestLog.GetNumQuestLogEntries() do
        local info = C_QuestLog.GetInfo(i)

        if not info.isHeader then
            --print(info.title) -- Prints the title of the quest

            --uiMapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(info.questID)
            --print("     " .. uiMapID)
        end
    end
end

local function getPlayerLocationInformation()
    currentPlayerMapID = C_Map.GetBestMapForUnit("player")
    info = C_Map.GetMapInfo(currentPlayerMapID)

    print("Current player map ID: " .. currentPlayerMapID)
    print("Name: " .. info.name)
    print("Map info (Map Type): " .. info.mapType)
    print("Parent: " .. info.parentMapID)
end

-- recursive function to go up until we find the "continent" level
local function recursiveLocationInformation(mapID, infoList)
    info = C_Map.GetMapInfo(mapID)

    -- if no parent or if we reach the "continent" enum
    if info.parentMapID == 0 or info.mapType == 2 then
        return
    end

    table.insert(infoList, info) -- append to the list
    recursiveLocationInformation(info.parentMapID, infoList) -- recursively call to append information about this map
end

-- Uses the recursive function to go up until we find a "continent" or something that has no parent
local function getLocationsUpToContinentForPlayer()
    currentPlayerMapID = C_Map.GetBestMapForUnit("player")
    mapInfo = {}

    recursiveLocationInformation(currentPlayerMapID, mapInfo)

    for _, info in pairs(mapInfo) do
        print(info.name)
    end
end

local function eventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        getLocationsUpToContinentForPlayer()
    end
end

-- Register Events
ZoneQuestTracker:RegisterEvent("PLAYER_ENTERING_WORLD")
ZoneQuestTracker:RegisterEvent("ZONE_CHANGED_NEW_AREA")

-- Set Script to Handle Events
ZoneQuestTracker:SetScript("OnEvent", eventHandler)