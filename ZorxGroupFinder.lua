zorxUtils.logger(5, "running myGroupFinderAddon.lua")
local mainAddonFrame = CreateFrame("Frame")
mainAddonFrame:RegisterEvent("ADDON_LOADED")
mainAddonFrame:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED");
utils = {}

mainAddonFrame:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" and addon == "ZorxGroupFinder" then
        if not ZORX_LFGPREFERENCES then
            zorxUtils.logger(4, "Generating default options.")
            ZORX_LFGPREFERENCES = zorxUtils.createDefaultOptions()
        end
        mainAddonFrame:Hide();

        DungeonFinderButton = CreateFrame("button","DungeonFinderButton", LFGListFrame.SearchPanel, "UIPanelButtonTemplate")
        DungeonFinderButton:SetHeight(24)
        DungeonFinderButton:SetWidth(60)
        DungeonFinderButton:SetPoint("TOP",100, -27)
        DungeonFinderButton:SetText("ZGF")
        DungeonFinderButton:SetScript("OnClick", function(self)
            zorxUtils.logger(4, "Clicked toggle mainframe, on Group Finder frame")
            -- PlaySound("igMainMenuOption")
            zorxUtils.toggleMainFrame(mainAddonFrame)
        end)

        toggleAddonOnFinder = CreateFrame("CheckButton","toggleAddonOnFinder", LFGListFrame.SearchPanel, "ChatConfigCheckButtonTemplate")
        toggleAddonOnFinder:SetHeight(30)
        toggleAddonOnFinder:SetWidth(30)
        toggleAddonOnFinder:SetPoint("TOP",64, -25)
        toggleAddonOnFinder:SetChecked(not ZORX_LFGPREFERENCES.addonDisabled)
        toggleAddonOnFinder:SetScript("OnClick", function(self)
            zorxUtils.logger(4, "Clicked toggle addon on group finder frame")
            zorxUtils.toggleAddon()
            toggleAddonOnFinder:SetChecked(not ZORX_LFGPREFERENCES.addonDisabled)
            getglobal("toggleAddonCheckBox"):SetChecked(not ZORX_LFGPREFERENCES.addonDisabled)
        end)
        mainAddonFrame.toggleAddonOnFinder = toggleAddonOnFinder

        main(mainAddonFrame);
    end
end)