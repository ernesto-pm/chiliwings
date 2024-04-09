-- Uses the recursive function to go up until we find a "continent" or something that has no parent
function getLocationsUpToContinentForPlayer()
    -- Inner recursive function to aggregate locations up to the continent where the player is located
    function recursiveLocationInformation(mapID, infoList)
        info = C_Map.GetMapInfo(mapID)

        -- if no parent or if we reach the "continent" enum
        if info.parentMapID == 0 or info.mapType == 2 then
            return
        end

        table.insert(infoList, info) -- append to the list
        recursiveLocationInformation(info.parentMapID, infoList) -- recursively call to append information about this map
    end

    currentPlayerMapID = C_Map.GetBestMapForUnit("player")
    mapInfo = {}
    recursiveLocationInformation(currentPlayerMapID, mapInfo)

    return mapInfo
end

function debugPlayerLocationInfo()
    currentPlayerMapID = C_Map.GetBestMapForUnit("player")
    info = C_Map.GetMapInfo(currentPlayerMapID)

    print("Current player map ID: " .. currentPlayerMapID)
    print("Name: " .. info.name)
    print("Map info (Map Type): " .. info.mapType)
    print("Parent: " .. info.parentMapID)
end