Quest = {}
Quest.__index = Quest

function Quest:new(questIndex)
    local quest = {}
    setmetatable(quest, Quest)

    -- Initialize our object
    local info = C_QuestLog.GetInfo(questIndex)
    local uiMapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(info.questID)
    quest.info = info
    quest.mapID = uiMapID

    return quest
end

function getAugmentedQuests()
    augmentedQuests = {}

    for i = 1, C_QuestLog.GetNumQuestLogEntries() do
        quest = Quest:new(i)
        table.insert(augmentedQuests, quest)
    end

    return augmentedQuests
end


-- Returns the quests that match the current zone (up to (but not including) continent )
function getAugmentedQuestsForCurrentPlayerZone()
    currentPlayerLocations = getLocationsUpToContinentForPlayer()

    augmentedQuests = {}
    for i = 1, C_QuestLog.GetNumQuestLogEntries() do
        quest = Quest:new(i)

        -- do not include headers in our calculations
        if not quest.info.isHeader then
            addLocation = false
            for _, locationInfo in ipairs(currentPlayerLocations) do
                print(quest.info.title)
                print(quest.mapID)

                if quest.mapID == locationInfo.mapID then
                    addLocation = true
                    break
                end
            end

            if addLocation then
                table.insert(augmentedQuests, quest)
            end
        end
    end

    return augmentedQuests
end