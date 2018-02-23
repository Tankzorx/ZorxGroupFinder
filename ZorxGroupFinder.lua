zorxUtils.logger(5, "running myGroupFinderAddon.lua")
local mainAddonFrame = CreateFrame("Frame")
mainAddonFrame:RegisterEvent("ADDON_LOADED")
mainAddonFrame:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED");
utils = {}

mainAddonFrame:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" and addon == "ZorxGroupFinder" then
        if not ZORX_LFGPREFERENCES or true then
            zorxUtils.logger(4, "Generating default options.")
            ZORX_LFGPREFERENCES = zorxUtils.createDefaultOptions()
        end
        mainAddonFrame:Hide();
        main(mainAddonFrame);

        DungeonFinderButton = CreateFrame("button","DungeonFinderButton", LFGListFrame.SearchPanel, "ActionButtonTemplate")
        DungeonFinderButton:SetHeight(24)
        DungeonFinderButton:SetWidth(60)
        DungeonFinderButton:SetPoint("TOP",100, -27)
        DungeonFinderButton:SetText("ZGF")
        DungeonFinderButton:SetScript("OnClick", function(self)
            zorxUtils.logger(4, "Clicked toggle on Group Finder frame")
            -- PlaySound("igMainMenuOption")
            toggleMainFrame(mainAddonFrame)
        end)
    end
end)