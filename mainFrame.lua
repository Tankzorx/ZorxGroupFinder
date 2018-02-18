zorxUtils.logger(5, "Parsing main.lua")

-- Toggle main frame visibility
toggleMainFrame = function()
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
    closeButton = CreateFrame("button","CloseButton", mainAddonFrame, "UIPanelButtonTemplate")
    closeButton:SetHeight(24)
    closeButton:SetWidth(60)
    closeButton:SetPoint("BOTTOM", mainAddonFrame, "BOTTOM", width/2 - 25, 0)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function(self)
        zorxUtils.logger(4, "Clicked Close")
        -- PlaySound("igMainMenuOption")
        mainAddonFrame:Hide() 
    end)

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
            self:ClearFocus()
        end)
    end

    
    

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