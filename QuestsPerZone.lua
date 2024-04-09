local QuestsPerZoneFrame = CreateFrame("Frame", "MyAddonMainFrame", UIParent);
QuestsPerZoneFrame:SetSize(220, 400); -- Width, Height
QuestsPerZoneFrame:SetPoint("CENTER"); -- Position it in the center of the screen
QuestsPerZoneFrame:SetMovable(true);
QuestsPerZoneFrame:EnableMouse(true);
QuestsPerZoneFrame:RegisterForDrag("LeftButton");
QuestsPerZoneFrame:SetScript("OnDragStart", QuestsPerZoneFrame.StartMoving);
QuestsPerZoneFrame:SetScript("OnDragStop", QuestsPerZoneFrame.StopMovingOrSizing);

QuestsPerZoneFrame.background = QuestsPerZoneFrame:CreateTexture(nil, "BACKGROUND");
QuestsPerZoneFrame.background:SetAllPoints(true);
QuestsPerZoneFrame.background:SetColorTexture(0, 0, 0, 0.5); -- Semi-transparent black

-- Adding event tracking
QuestsPerZoneFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
QuestsPerZoneFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")


local function eventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        -- Clear existing item frames to avoid overlap and memory leaks
        for i, frame in ipairs(QuestsPerZoneFrame.itemFrames or {}) do
            frame:Hide();
            frame:SetParent(nil);
        end
        QuestsPerZoneFrame.itemFrames = {};

        -- Render player location debug
        playerLocations = getLocationsUpToContinentForPlayer()
        for i, location in ipairs(playerLocations) do
            local itemFrame = CreateFrame("Frame", "PlayerLocation" .. i, QuestsPerZoneFrame);
            itemFrame:SetSize(200, 20); -- Width, Height
            itemFrame:SetPoint("TOPLEFT", QuestsPerZoneFrame, "TOPLEFT", 10, -10 - (i-1) * (20 + 5)); -- 5 pixels space between rows

            local itemText = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
            itemText:SetPoint("LEFT");
            itemText:SetText("MapID: " .. location.mapID .. " (Type: " .. location.mapType .. ")");

            table.insert(QuestsPerZoneFrame.itemFrames, itemFrame);
        end

        -- Render quessts
        quests = getAugmentedQuestsForCurrentPlayerZone()
        for i, quest in ipairs(quests) do
            i = #playerLocations + i
            local itemFrame = CreateFrame("Frame", "QuestItemFrame" .. i, QuestsPerZoneFrame);
            itemFrame:SetSize(200, 20); -- Width, Height
            itemFrame:SetPoint("TOPLEFT", QuestsPerZoneFrame, "TOPLEFT", 10, -10 - (i-1) * (20 + 5)); -- 5 pixels space between rows

            local itemText = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
            itemText:SetPoint("LEFT");
            itemText:SetText(quest.info.title .. " - " .. quest.mapID);

            table.insert(QuestsPerZoneFrame.itemFrames, itemFrame);
        end
    end
end

-- Set Script to Handle Events
QuestsPerZoneFrame:SetScript("OnEvent", eventHandler)