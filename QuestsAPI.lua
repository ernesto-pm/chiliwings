local function getAugmentedQuests()

    augmentedQuests = {}
    for i = 1, C_QuestLog.GetNumQuestLogEntries() do
        local info = C_QuestLog.GetInfo(i)
        if not info.isHeader then
            local additionalHighlights = C_QuestLog.GetQuestAdditionalHighlights(info.questID)





            --print(info.title) -- Prints the title of the quest

            --uiMapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(info.questID)
            --print("     " .. uiMapID)
        end
    end
end