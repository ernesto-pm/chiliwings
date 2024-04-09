local ZoneQuestTracker = CreateFrame("Frame")

local function eventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        local realZoneText = GetRealZoneText()
        local subZoneText = GetSubZoneText()
        local zoneText = GetZoneText()

        print("Current player map ID: " .. C_Map.GetBestMapForUnit("player"))
        print("Real Zone name: " .. realZoneText .. "") -- i.e Thaldrazus
        print("Sub zone name: " .. subZoneText .. "") -- i.e The petitioner's course
        print("Zone name: " .. zoneText .. "") -- i.e thaldrazus

        for i = 1, C_QuestLog.GetNumQuestLogEntries() do
            local info = C_QuestLog.GetInfo(i)

            if not info.isHeader then
                print(info.title) -- Prints the title of the quest

                uiMapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(info.questID)
                print("     " .. uiMapID)
            end
        end
    end
end

-- Register Events
ZoneQuestTracker:RegisterEvent("PLAYER_ENTERING_WORLD")
ZoneQuestTracker:RegisterEvent("ZONE_CHANGED_NEW_AREA")

-- Set Script to Handle Events
ZoneQuestTracker:SetScript("OnEvent", eventHandler)