zorxUtils.logger(5, "running filtering.lua")

-- Returns true if any nameMatcher matches group title
function checkNameOk(name)
    -- Filter based on group name
    if (ZORX_LFGPREFERENCES.nameMatchers and
        #ZORX_LFGPREFERENCES.nameMatchers > 0)
    then
        local nameMatchers = ZORX_LFGPREFERENCES.nameMatchers
        local foundMatch = false
        for i = #nameMatchers, 1, -1 do
            if string.find(name:lower(), nameMatchers[i]:lower()) then
                foundMatch = true
            end
        end
        return foundMatch
    else
        return true
    end
end

-- Returns true if any nameMatcher matches group title
function checkDescOk(desc)
    -- Filter based on group name
    if (ZORX_LFGPREFERENCES.descMatchers and
        #ZORX_LFGPREFERENCES.descMatchers > 0)
    then
        local descMatchers = ZORX_LFGPREFERENCES.descMatchers
        local foundMatch = false
        for i = #descMatchers, 1, -1 do
            if string.find(desc, descMatchers[i]) then
                foundMatch = true
            end
        end
        return foundMatch
    else
        return true
    end
end

-- Returns true if ilvl is acceptable according to settings.
function checkIlvlOk(ilvl)
    -- Filter based on ilvlReq
    if (ZORX_LFGPREFERENCES.ilvlReq) then
        return (ilvl and (ilvl > ZORX_LFGPREFERENCES.ilvlReq))
    else
        return true
    end
end

function checkMemberRolesOk(groupID)
    local numTanks, numDps, numHealers = 0, 0, 0
    local numTanksOk, numDpsOk, numHealersOk = true, true, true
    for j = 1, 5, 1 do
                local role, class, classButDifferent = C_LFGList.GetSearchResultMemberInfo(groupID, j)
                if role then
                    if role == "DAMAGER" then
                        numDps = numDps + 1
                    elseif role == "TANK" then
                        numTanks = numTanks + 1
                    else
                        numHealers = numHealers + 1
                    end
                end
            end
    if ZORX_LFGPREFERENCES.minTankCount then
        numTanksOk = numTanksOk and numTanks >= ZORX_LFGPREFERENCES.minTankCount
    end
    if ZORX_LFGPREFERENCES.maxTankCount then
        numTanksOk = numTanksOk and numTanks <= ZORX_LFGPREFERENCES.maxTankCount
    end
    if ZORX_LFGPREFERENCES.minDpsCount then
        numDpsOk = numDpsOk and numDps >= ZORX_LFGPREFERENCES.minDpsCount
    end
    if ZORX_LFGPREFERENCES.maxDpsCount then
        numDpsOk = numDpsOk and numDps <= ZORX_LFGPREFERENCES.maxDpsCount
    end
    if ZORX_LFGPREFERENCES.minHealerCount then
        numHealersOk = numHealersOk and numHealers >= ZORX_LFGPREFERENCES.minHealerCount
    end
    if ZORX_LFGPREFERENCES.maxHealerCount then
        numHealersOk = numHealersOk and numHealers <= ZORX_LFGPREFERENCES.maxHealerCount
    end
    return  numTanksOk and numDpsOk and numHealersOk
end



function initFilter()
    local GetSearchResults, GetSearchResultInfo = C_LFGList.GetSearchResults, C_LFGList.GetSearchResultInfo
	local GetApplications, ReportSearchResult = C_LFGList.GetApplications, C_LFGList.ReportSearchResult
    local f = CreateFrame("Frame", nil, PVEFrame)
    f:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
    f:RegisterEvent("LFG_LIST_SEARCH_FAILED")
    local filter = function (self, e)
        -- General idea stolen from the addon "badboy".
        zorxUtils.logger(4, "Filter func event:" .. e)

        local _, results = GetSearchResults()
        zorxUtils.logger(4, "search results length:" .. #results)
        for i = #results, 1, -1 do
            local id, t, name, description, voiceChat, ilvl, age, _, _, _, _, _, numMembers = GetSearchResultInfo(results[i])
            local shouldRemove = false
            shouldRemove = shouldRemove or (not checkNameOk(name))
            shouldRemove = shouldRemove or (not checkDescOk(description))
            shouldRemove = shouldRemove or (not checkIlvlOk(ilvl))
            shouldRemove = shouldRemove or (not checkMemberRolesOk(id))
            if shouldRemove then
                -- not checkMemberRolesOk(groupID, numMembers)
                table.remove(results, i)
            end
            
        end

        LFGListUtil_SortSearchResults(results) -- Some LFG filter addons hook this function to do custom sorting, let's cooperate by using it so they customize our list.
        LFGListFrame.SearchPanel.results = results -- Attach results table to frame
        LFGListFrame.SearchPanel.totalResults = #results -- Attach result counter to frame
        LFGListFrame.SearchPanel.applications = GetApplications() -- Attach applications to frame
        LFGListSearchPanel_UpdateResults(LFGListFrame.SearchPanel) -- Finally, feed frame holding the results to the panel
    end
    
    f:SetScript("OnEvent", filter)
    
end
