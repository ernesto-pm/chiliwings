ChiliWings = LibStub("AceAddon-3.0"):NewAddon("ChiliWings", "AceConsole-3.0", "AceEvent-3.0")

function ChiliWings:OnEnable()
    self:Print("Hello world?")
    self:RegisterEvent("ZONE_CHANGED")
end

function ChiliWings:ZONE_CHANGED()
    local subzone = GetSubZoneText()

    self:Print("You have changed zones!", GetZoneText(), subzone)
    if GetBindLocation() == subzone then
        self:Print("Welcome Home!")
    end
end