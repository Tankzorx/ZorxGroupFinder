zorxUtils.logger(5, "running myGroupFinderAddon.lua")
mainAddonFrame = CreateFrame("Frame")
mainAddonFrame:RegisterEvent("ADDON_LOADED")
mainAddonFrame:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED");
utils = {}


mainAddonFrame:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" and addon == "myGroupFinderAddon" then

        if not ZORX_LFGPREFERENCES or true then
            zorxUtils.logger(4, "Generating default options.")
            ZORX_LFGPREFERENCES = zorxUtils.createDefaultOptions()
        end

        DungeonFinderButton = CreateFrame("button","DungeonFinderButton", LFGListFrame.SearchPanel, "UIPanelButtonTemplate")
        DungeonFinderButton:SetHeight(24)
        DungeonFinderButton:SetWidth(60)
        DungeonFinderButton:SetPoint("TOP",100, -27)
        DungeonFinderButton:SetText("ZGF")
        DungeonFinderButton:SetScript("OnClick", function(self)
            zorxUtils.logger(4, "Clicked toggle on Group Finder frame")
            -- PlaySound("igMainMenuOption")
            toggleMainFrame()
        end)
        
        mainAddonFrame:Hide();
        main();
    end

end)

-- http://wow.gamepedia.com/World_of_Warcraft_API
-- Check the functions defined on the object C_LFGList
-- Assumed important functions:
-- C_LFGList.Search(categoryID, "query" [, filter [, preferredFilters] ]) - This function is not yet documented.
-- C_LFGList.GetAvailableActivities([categoryID[, groupID [, filter]]]) - Returns a list of available activityIDs.
-- C_LFGList.GetAvailableCategories([filter]) - Returns a list of available categoryIDs.
-- Group Finder Functions

-- Introduced in Patch 3.3.0 as the "Dungeon Finder" and "Raid Browser", this UI was completely overhauled in Patch 6.0.3 and renamed to "Group Finder".

--     C_LFGList.AcceptInvite(resultID) - This function is not yet documented.
--     C_LFGList.ApplyToGroup(resultID, comment, tankOK, healerOK, damageOK) - This function is not yet documented.
--     C_LFGList.CancelApplication(resultID) - This function is not yet documented.
--     C_LFGList.ClearSearchResults() - This function is not yet documented.
--     C_LFGList.CreateListing("groupName", itemLevel, "voiceChat", "comment", autoAccept) - This function is not yet documented.
--     C_LFGList.DeclineApplicant(applicantID) - This function is not yet documented.
--     C_LFGList.DeclineInvite(resultID) - This function is not yet documented.
--     C_LFGList.GetActiveEntryInfo() - Returns information about your currently listed group.
--     C_LFGList.GetActivityGroupInfo(groupID) - Returns information about an activity group.
--     C_LFGList.GetActivityInfo(activityID) - Returns information about an activity for premade groups.
--     C_LFGList.GetActivityInfoExpensive(activityID) - Checks if you are in the zone associated with an activity.
--     C_LFGList.GetApplicantInfo(applicantID) - Returns status informations and custom message of an applicant
--     C_LFGList.GetApplicantMemberInfo(applicantID, memberIndex) - Returns name, class, level and more about an applicant group member
--     C_LFGList.GetApplicantMemberStats(applicantID, memberIndex) - Returns stats about an applicant group member
--     C_LFGList.GetApplicants() - Returns a table with applicantIDs
--     C_LFGList.GetApplicationInfo(resultID) - This function is not yet documented.
--     C_LFGList.GetApplications() - This function is not yet documented.
--     C_LFGList.GetAvailableActivities([categoryID[, groupID [, filter]]]) - Returns a list of available activityIDs.
--     C_LFGList.GetAvailableActivityGroups(categoryID[,filter]) - Returns a list of available groupIDs.
--     C_LFGList.GetAvailableCategories([filter]) - Returns a list of available categoryIDs.
--     C_LFGList.GetAvailableRoles() - This function is not yet documented.
--     C_LFGList.GetCategoryInfo(categoryID) - Returns information about a specific category.
--     C_LFGList.GetNumApplicants() - This function is not yet documented.
--     C_LFGList.GetNumApplications() - This function is not yet documented.
--     C_LFGList.GetNumInvitedApplicantMembers() - This function is not yet documented.
--     C_LFGList.GetNumPendingApplicantMembers() - This function is not yet documented.
--     C_LFGList.GetRoleCheckInfo() - This function is not yet documented.
--     C_LFGList.GetSearchResultEncounterInfo(resultID) - This function is not yet documented.
--     C_LFGList.GetSearchResultFriends(resultID) - This function is not yet documented.
--     C_LFGList.GetSearchResultInfo(resultID) - This function is not yet documented.
--     C_LFGList.GetSearchResultMemberCounts(resultID) - This function is not yet documented.
--     C_LFGList.GetSearchResultMemberInfo(resultID, memberIndex) - This function is not yet documented.
--     C_LFGList.GetSearchResults() - returns numResultID, totalResultID
--     C_LFGList.HasActivityList() - This function is not yet documented.
--     C_LFGList.InviteApplicant(applicantID) - This function is not yet documented.
--     C_LFGList.IsCurrentlyApplying() - This function is not yet documented.
--     C_LFGList.RefreshApplicants() - This function is not yet documented.
--     C_LFGList.RemoveApplicant(applicantID) - This function is not yet documented.
--     C_LFGList.RemoveListing() - This function is not yet documented.
--     C_LFGList.ReportApplicant(applicantID) - This function is not yet documented.
--     C_LFGList.ReportSearchResult(resultID, complaintType) - This function is not yet documented.
--     C_LFGList.RequestAvailableActivities() - This function is not yet documented.
--     C_LFGList.Search(categoryID, "query" [, filter [, preferredFilters] ]) - This function is not yet documented.
--     C_LFGList.SetApplicantMemberRole(applicantID, memberIndex, "ROLE") - This function is not yet documented.
--     C_LFGList.UpdateListing(lfgID, "groupName", itemLevel, "voiceChat", "comment", autoAccept) - This function is not yet documented. 


        -- if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
    -- 	if mainAddonFrame:IsVisible() == false then
    -- 		print("Addon frame closed. Not acting on this search.")
    -- 		return
    -- 	end
    -- 	print("THE RESULTS ARE IN");
    -- 	numResults, resultIDTable = C_LFGList.GetSearchResults();
    -- 	for i,v in ipairs(resultIDTable) do
    -- 		-- print(v)
    -- 		local groupID,dungeonID,title,description,voiceComm,ilvlReq,seven,queryNumber,one,two,three,four,leader,six,seven,eight,nine = C_LFGList.GetSearchResultInfo(v);
    -- 		print("groupID " .. groupID)
    -- 		print("dungeonID " .. dungeonID)
    -- 		print("title " .. title)
    -- 		print("description " .. description)
    -- 		print("voiceComm " .. voiceComm)
    -- 		print("ilvlReq " .. ilvlReq)
    -- 		print("Unknown:" ..  tostring(seven))
    -- 		print("query Number? " .. queryNumber)
    -- 		print(one)
    -- 		print(two)
    -- 		print(three)
    -- 		print(four)
    -- 		print("leader: " .. tostring(leader))
    -- 		print(six)
    -- 		print(seven)
    -- 		print(eight)
    -- 		print(nine)
    -- 		print(" ")
            
    -- 	end
    -- 	print("Results: " .. numResults)
    -- end