local ZoneQuestTracker = CreateFrame("Frame")

local function eventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        local zoneName = GetRealZoneText()
        print("Active Quests in " .. zoneName .. ":")
        for i = 1, C_QuestLog.GetNumQuestLogEntries() do
            local info = C_QuestLog.GetInfo(i)

            if not info.isHeader then
                print(info.title) -- Prints the title of the quest
            end
        end
    end
end

-- Register Events
ZoneQuestTracker:RegisterEvent("PLAYER_ENTERING_WORLD")
ZoneQuestTracker:RegisterEvent("ZONE_CHANGED_NEW_AREA")

-- Set Script to Handle Events
ZoneQuestTracker:SetScript("OnEvent", eventHandler)