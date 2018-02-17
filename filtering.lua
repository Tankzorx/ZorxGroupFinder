zorxUtils.logger(5, "running filtering.lua")
function initFiltering()
    local GetSearchResults, GetSearchResultInfo = C_LFGList.GetSearchResults, C_LFGList.GetSearchResultInfo
	local GetApplications, ReportSearchResult = C_LFGList.GetApplications, C_LFGList.ReportSearchResult
    local f = CreateFrame("Frame", nil, PVEFrame)
    f:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
    f:RegisterEvent("LFG_LIST_SEARCH_FAILED")
    local filter = function (self, e)
        zorxUtils.logger(4, "Filter func event:" .. e)
        local s = e ~= "LFG_LIST_SEARCH_RESULTS_RECEIVED"
        if s then
            zorxUtils.logger(4, "LFG search failed.")
        end
        local _, results = GetSearchResults()
        zorxUtils.logger(4, "search results length:" .. #results)
        
        if not s then
            -- local _, results = GetSearchResults()
            for i = #results, 1, -1 do
                local id, t, name, description, voiceChat, ilvlReq = GetSearchResultInfo(results[i])
                local removeEntry = false

                if not removeEntry and (
                    ZORX_LFGPREFERENCES.nameMatchers and 
                    #ZORX_LFGPREFERENCES.nameMatchers > 0
                ) then
                    local descMatchers = ZORX_LFGPREFERENCES.nameMatchers
                    local foundMatch = false
                    for i = #descMatchers, 1, -1 do
                        if string.find(name, descMatchers[i]) then
                            foundMatch = true
                        end
                    end
                    if not foundMatch then
                        removeEntry = true;
                    end
                end

                if (not removeEntry and ZORX_LFGPREFERENCES.ilvlReq) then
                    if (ilvlReq < ZORX_LFGPREFERENCES.ilvlReq or not ilvlReq) then
                        removeEntry = true
                    end
                end

                if removeEntry then
                    table.remove(results, i)
                end
                
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