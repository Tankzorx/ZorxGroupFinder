zorxUtils.logger(5, "Parsing main.lua")

-- Toggle main frame visibility
toggleMainFrame = function(mainAddonFrame)
    if mainAddonFrame:IsVisible() then
        zorxUtils.logger(4, "hiding frame")
        mainAddonFrame:Hide()
    else
        zorxUtils.logger(4, "showing frame")
        mainAddonFrame:Show()
    end
end

local ctx = {}

function setupMainFrame(mainFrame)

    

    mainFrame:SetBackdrop({
        bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
        edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
        tile=1, tileSize=32, edgeSize=32, 
        insets={left=11, right=12, top=12, bottom=11}
    })
    local width,height = 300, 300
    mainFrame:SetWidth(width)
    mainFrame:SetHeight(height)
    mainFrame:SetPoint("CENTER",UIParent)
    mainFrame:EnableMouse(true)
    mainFrame:SetMovable(true)
    mainFrame:RegisterForDrag("LeftButton")
    mainFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    mainFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    mainFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    closeButton = CreateFrame("button","CloseButton", mainFrame, "UIPanelButtonTemplate")
    closeButton:SetHeight(24)
    closeButton:SetWidth(60)
    closeButton:SetPoint("BOTTOM",0, -5)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function(self)
        zorxUtils.logger(4, "Clicked Close")
        -- PlaySound("igMainMenuOption")
        mainFrame:Hide() 
    end)

    local line = mainFrame:CreateTexture()
    line:SetTexture(1 ,0, 0)
    line:SetSize(width - 30, 3)
    line:SetPoint("TOP", 0, -50)

    -- Shared font throughout
    font = CreateFont("myFont")
    font:SetFont("Fonts\\FRIZQT__.TTF", 10)

    -- LABELS
    local lMinTanks = mainFrame:CreateFontString("lMinTanks", "OVERLAY")
    lMinTanks:SetFont(font:GetFont())
    lMinTanks:SetTextColor(0.85, 0.85, 0.85, 1)
    lMinTanks:SetText("Min. Tanks")
    lMinTanks:SetPoint("TOPLEFT", 15, -15)
    lMinTanks:Show()

    local lMaxTanks = mainFrame:CreateFontString("lMaxTanks", "OVERLAY")
    lMaxTanks:SetFont(font:GetFont())
    lMaxTanks:SetTextColor(0.85, 0.85, 0.85, 1)
    lMaxTanks:SetText("Max. Tanks")
    lMaxTanks:SetPoint("TOPLEFT", 15, -30)
    lMaxTanks:Show()

    local lMinDps = mainFrame:CreateFontString("lMinDps", "OVERLAY")
    lMinDps:SetFont(font:GetFont())
    lMinDps:SetTextColor(0.85, 0.85, 0.85, 1)
    lMinDps:SetText("Min. Dps")
    lMinDps:SetPoint("TOPLEFT", 110, -15)
    lMinDps:Show()

    local lMaxDps = mainFrame:CreateFontString("lMaxDps", "OVERLAY")
    lMaxDps:SetFont(font:GetFont())
    lMaxDps:SetTextColor(0.85, 0.85, 0.85, 1)
    lMaxDps:SetText("Max. Dps")
    lMaxDps:SetPoint("TOPLEFT", 110, -30)
    lMaxDps:Show()

    local lMinHealers = mainFrame:CreateFontString("lMinHealers", "OVERLAY")
    lMinHealers:SetFont(font:GetFont())
    lMinHealers:SetTextColor(0.85, 0.85, 0.85, 1)
    lMinHealers:SetText("Min. Healers")
    lMinHealers:SetPoint("TOPLEFT", 190, -15)
    lMinHealers:Show()

    local lMaxHealers = mainFrame:CreateFontString("lMaxHealers", "OVERLAY")
    lMaxHealers:SetFont(font:GetFont())
    lMaxHealers:SetTextColor(0.85, 0.85, 0.85, 1)
    lMaxHealers:SetText("Max. Healers")
    lMaxHealers:SetPoint("TOPLEFT", 190, -30)
    lMaxHealers:Show()

    -- EDITBOXES
    local ebMinTanks = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    ebMinTanks:SetPoint("TOPLEFT", 80, -15)
    ebMinTanks.optVal = "minTankCount"
    ebMinTanks:Insert(ZORX_LFGPREFERENCES.minTankCount)

    local ebMaxTanks = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    ebMaxTanks:SetPoint("TOPLEFT", 80, -30)
    ebMaxTanks.optVal = "maxTankCount"
    ebMaxTanks:Insert(ZORX_LFGPREFERENCES.maxTankCount)

    local ebMinDps = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    ebMinDps:SetPoint("TOPLEFT", 168, -15)
    ebMinDps.optVal = "minDpsCount"
    ebMinDps:Insert(ZORX_LFGPREFERENCES.minDpsCount)

    local ebMaxDps = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    ebMaxDps:SetPoint("TOPLEFT", 168, -30)
    ebMaxDps.optVal = "maxDpsCount"
    ebMaxDps:Insert(ZORX_LFGPREFERENCES.maxDpsCount)

    local ebMinHealers = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    ebMinHealers:SetPoint("TOPLEFT", 265, -15)
    ebMinHealers.optVal = "minHealerCount"
    ebMinHealers:Insert(ZORX_LFGPREFERENCES.minHealerCount)

    local ebMaxHealers = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    ebMaxHealers:SetPoint("TOPLEFT", 265, -30)
    ebMaxHealers.optVal = "maxHealerCount"
    ebMaxHealers:Insert(ZORX_LFGPREFERENCES.maxHealerCount)

    local editBoxArr = {}
    editBoxArr[#editBoxArr + 1] = ebMinTanks
    editBoxArr[#editBoxArr + 1] = ebMinDps
    editBoxArr[#editBoxArr + 1] = ebMinHealers
    editBoxArr[#editBoxArr + 1] = ebMaxTanks
    editBoxArr[#editBoxArr + 1] = ebMaxDps
    editBoxArr[#editBoxArr + 1] = ebMaxHealers

    -- Settings for all editboxes
    for i=1,#editBoxArr do
        editBoxArr[i]:SetFont(font:GetFont())
        editBoxArr[i]:SetAutoFocus(false)
        editBoxArr[i]:SetSize(20,10)
        editBoxArr[i]:SetNumeric(true)

        editBoxArr[i]:SetScript("OnEnterPressed", function (self)
            ZORX_LFGPREFERENCES[self.optVal] = tonumber(self:GetText())
            zorxUtils.logger(4, "Setting " .. self.optVal .. " to " .. self:GetText())
            self:ClearFocus()
        end)

        editBoxArr[i]:SetScript("OnEditFocusLost", function (self)
            ZORX_LFGPREFERENCES[self.optVal] = tonumber(self:GetText())
            zorxUtils.logger(4, "Setting " .. self.optVal .. " to " .. self:GetText())
            self:ClearFocus()
        end)
    end

    -- NAME MATCHERS
    local lNameMatchers = mainFrame:CreateFontString(nil, "OVERLAY")
    lNameMatchers:SetFont(font:GetFont())
    lNameMatchers:SetTextColor(0.85, 0.85, 0.85, 1)
    lNameMatchers:SetText("Name Matchers   Create: ")
    lNameMatchers:SetPoint("TOPLEFT", 15, -57)
    lNameMatchers:Show()

    
    local ebCreateNameMatcher = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    ebCreateNameMatcher:SetPoint("TOPLEFT", 150, -59)
    ebCreateNameMatcher:SetFont(font:GetFont())
    ebCreateNameMatcher:SetAutoFocus(false)
    ebCreateNameMatcher:SetSize(100, 9)
    ebCreateNameMatcher:SetMaxLetters(15)
    ebCreateNameMatcher:SetScript("OnEnterPressed", function (self)
        if ebCreateNameMatcher:GetText() and string.len(ebCreateNameMatcher:GetText()) > 0 then
            zorxUtils.logger(4, "Adding name matcher:" .. ebCreateNameMatcher:GetText())
            ZORX_LFGPREFERENCES.nameMatchers[#ZORX_LFGPREFERENCES.nameMatchers + 1] = ebCreateNameMatcher:GetText()
            if mainFrame.ebNameMatcherArr then
                for i=1,#mainFrame.ebNameMatcherArr do
                    mainFrame.ebNameMatcherArr[i]:Hide()
                    mainFrame.ebNameMatcherArr[i]:SetParent(nil)
                end
            end
            ebCreateNameMatcher:SetText("")
            createNameMatcherEBs()

        end
    end)


    function createNameMatcherEBs()
        local indentCount = 25
        local yIndentCount = 0
        local ebArr = {}
        for i=1,#ZORX_LFGPREFERENCES.nameMatchers do
            -- TODO: THIS COULD RENDER LONG STRINGS WAY BETTER/PRETTIER.
            local matchStr =ZORX_LFGPREFERENCES.nameMatchers[i]
            local strPixelWidth = string.len(matchStr)*6 + 4
            local ebNameMatcher = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
            ebNameMatcher:SetPoint("TOPLEFT", indentCount, -78 - yIndentCount)
            ebNameMatcher:SetFont(font:GetFont())
            ebNameMatcher:SetAutoFocus(false)
            ebNameMatcher:SetHeight(10)
            ebNameMatcher:SetWidth(strPixelWidth)
            ebNameMatcher:Insert(matchStr)
            indentCount = indentCount + strPixelWidth + 10
            if indentCount > width - 19 then
                indentCount = 25
                yIndentCount = yIndentCount + 19
            end

            ebNameMatcher:SetScript("OnEnterPressed", function (self)
                table.remove(ZORX_LFGPREFERENCES.nameMatchers, i)
                if mainFrame.ebNameMatcherArr then
                    for i=1,#mainFrame.ebNameMatcherArr do
                        mainFrame.ebNameMatcherArr[i]:Hide()
                        mainFrame.ebNameMatcherArr[i]:SetParent(nil)
                    end
                end
                createNameMatcherEBs()
            end)
            ebArr[#ebArr + 1] = ebNameMatcher
        end
        mainFrame.ebNameMatcherArr = ebArr
        return ebArr
    end
    mainFrame:SetScript("OnShow", function (self) 
        -- If old eb's are found, remove them
        if mainFrame.ebNameMatcherArr then
            for i=1,#mainFrame.ebNameMatcherArr do
                mainFrame.ebNameMatcherArr[i]:Hide()
                mainFrame.ebNameMatcherArr[i]:SetParent(nil)
            end
        end
        -- Store new edit boxes so they can be removed/updated later.
        mainFrame.ebNameMatcherArr = createNameMatcherEBs()
    end)

    -- -- DESC MATCHERS NOT SURE IF NEEDED. KEEP COMMENTED OUT I GUESS.
    -- local lDescMatchers = mainFrame:CreateFontString(nil, "OVERLAY")
    -- lDescMatchers:SetFont(font:GetFont())
    -- lDescMatchers:SetTextColor(0.85, 0.85, 0.85, 1)
    -- lDescMatchers:SetText("Desc Matchers   Create: ")
    -- lDescMatchers:SetPoint("TOPLEFT", 15, -117)
    -- lDescMatchers:Show()

    -- local ebCreateDescMatcher = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    -- ebCreateDescMatcher:SetPoint("TOPLEFT", 150, -117)
    -- ebCreateDescMatcher:SetFont(font:GetFont())
    -- ebCreateDescMatcher:SetAutoFocus(false)
    -- ebCreateDescMatcher:SetSize(100, 9)
    -- ebCreateDescMatcher:SetMaxLetters(15)
    -- ebCreateDescMatcher:SetScript("OnEnterPressed", function (self)
    --     if ebCreateDescMatcher:GetText() and string.len(ebCreateDescMatcher:GetText()) > 0 then
    --         zorxUtils.logger(4, "Adding Desc matcher:" .. ebCreateDescMatcher:GetText())
    --         ZORX_LFGPREFERENCES.descMatchers[#ZORX_LFGPREFERENCES.descMatchers + 1] = ebCreateDescMatcher:GetText()
    --         if mainFrame.ebDescMatcherArr then
    --             for i=1,#mainFrame.ebDescMatcherArr do
    --                 mainFrame.ebDescMatcherArr[i]:Hide()
    --                 mainFrame.ebDescMatcherArr[i]:SetParent(nil)
    --             end
    --         end
    --         ebCreateDescMatcher:SetText("")
    --         createDescMatcherEBs()

    --     end
    -- end)

    -- function createDescMatcherEBs()
    --     local indentCount = 25
    --     local yIndentCount = 0
    --     local ebArr = {}
    --     for i=1,#ZORX_LFGPREFERENCES.descMatchers do
    --         -- TODO: THIS COULD RENDER LONG STRINGS WAY BETTER/PRETTIER.
    --         local matchStr =ZORX_LFGPREFERENCES.descMatchers[i]
    --         local strPixelWidth = string.len(matchStr)*6 + 4
    --         local ebDescMatcher = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
    --         ebDescMatcher:SetPoint("TOPLEFT", indentCount, -135 - yIndentCount)
    --         ebDescMatcher:SetFont(font:GetFont())
    --         ebDescMatcher:SetAutoFocus(false)
    --         ebDescMatcher:SetHeight(10)
    --         ebDescMatcher:SetWidth(strPixelWidth)
    --         ebDescMatcher:Insert(matchStr)
    --         indentCount = indentCount + strPixelWidth + 10
    --         if indentCount > width - 19 then
    --             indentCount = 25
    --             yIndentCount = yIndentCount + 19
    --         end

    --         ebDescMatcher:SetScript("OnEnterPressed", function (self)
    --             table.remove(ZORX_LFGPREFERENCES.descMatchers, i)
    --             if mainFrame.ebDescMatcherArr then
    --                 for i=1,#mainFrame.ebDescMatcherArr do
    --                     mainFrame.ebDescMatcherArr[i]:Hide()
    --                     mainFrame.ebDescMatcherArr[i]:SetParent(nil)
    --                 end
    --             end
    --             createDescMatcherEBs()
    --         end)
    --         ebArr[#ebArr + 1] = ebDescMatcher
    --     end
    --     mainFrame.ebDescMatcherArr = ebArr
    --     return ebArr
    -- end
    -- mainFrame:SetScript("OnShow", function (self) 
    --     -- If old eb's are found, remove them
    --     if mainFrame.ebDescMatcherArr then
    --         for i=1,#mainFrame.ebDescMatcherArr do
    --             mainFrame.ebDescMatcherArr[i]:Hide()
    --             mainFrame.ebDescMatcherArr[i]:SetParent(nil)
    --         end
    --     end
    --     -- Store new edit boxes so they can be removed/updated later.
    --     mainFrame.ebDescMatcherArr = createDescMatcherEBs()
    -- end)
    -- -- DESC MATCHERS END

    -- --content frame 
    -- local content = CreateFrame("Frame", nil, ScrollFrame) 
    -- content:SetSize(660, 1000) 
    -- local texture = content:CreateTexture() 
    -- texture:SetAllPoints() 
    -- texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Gold-Background") 
    -- content.texture = texture 
    -- ScrollFrame.content = content 
     
    -- ScrollFrame:SetScrollChild(content)
end

    -- --[[
    --     SCROLLING AREA. SO MUCH CODE JESUS.
    --     ]]
    --     scrollArea = CreateFrame("Frame","ScrollArea",mainAddonFrame)
    --     scrollArea:SetHeight(400)
    --     scrollArea:SetWidth(660)
    --     scrollArea:SetPoint("TOPLEFT",10,-10)
    --     scrollArea:SetBackdrop(
    --         { 
    --           bgFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
    --             tile = false, tileSize = 0, edgeSize = 32, 
    --             insets = { left = 0, right = 0, top = 0, bottom = 0 }
    --         })
    --     scrollArea:SetBackdropColor(0,1,0,1)
        
    --     ScrollFrame = CreateFrame("ScrollFrame","ScrollArea",mainAddonFrame)
    --     ScrollFrame:SetHeight(400)
    --     ScrollFrame:SetWidth(660)
    --     ScrollFrame:SetPoint("TOPLEFT",10,-10)
    --     ScrollFrame:SetBackdrop(
    --         { 
    --           bgFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
    --             tile = false, tileSize = 0, edgeSize = 32, 
    --             insets = { left = 0, right = 0, top = 0, bottom = 0 }
    --         })
    --     ScrollFrame:SetBackdropColor(0,1,0,1)
    
    --     --scrollbar 
    --     scrollbar = CreateFrame("Slider", nil, ScrollFrame, "UIPanelScrollBarTemplate") 
    --     scrollbar:SetPoint("TOPLEFT", scrollArea, "TOPRIGHT", 4, -16) 
    --     scrollbar:SetPoint("BOTTOMLEFT", scrollArea, "BOTTOMRIGHT", 4, 16) 
    --     scrollbar:SetMinMaxValues(1, 200) 
    --     scrollbar:SetValueStep(1) 
    --     scrollbar.scrollStep = 1
    --     scrollbar:SetValue(0) 
    --     scrollbar:SetWidth(16) 
    --     scrollbar:SetScript("OnValueChanged",
    --         function (self, value) 
    --             self:GetParent():SetVerticalScroll(value) 
    --         end
    --     ) 
    --     local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
    --     scrollbg:SetAllPoints(scrollbar) 
    --     mainAddonFrame.scrollbar = scrollbar