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

function setupMainFrame(mainFrame)
    mainFrame:SetBackdrop({
        bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
        edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
        tile=1, tileSize=32, edgeSize=32, 
        insets={left=11, right=12, top=12, bottom=11}
  })
  mainFrame:SetWidth(700)
  mainFrame:SetHeight(600)
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
	closeButton:SetPoint("BOTTOM", mainAddonFrame, "BOTTOM", 310, 10)
	closeButton:SetText("Close")
	closeButton:SetScript("OnClick", function(self)
		zorxUtils.logger(4, "Clicked Close")
		-- PlaySound("igMainMenuOption")
		mainAddonFrame:Hide() 
    end)

    searchButton = CreateFrame("button","SearchButton", mainAddonFrame, "UIPanelButtonTemplate")
	searchButton:SetHeight(24)
	searchButton:SetWidth(60)
	searchButton:SetPoint("BOTTOM", mainAddonFrame, "BOTTOM", -310, 10)
	searchButton:SetText("Search")
	searchButton:SetScript("OnClick", function(self) 
		print("Clicked Search")
		veryCustomSearch()
		PlaySound("igMainMenuOption") 
    end)
    
    --[[
		SCROLLING AREA. SO MUCH CODE JESUS.
		]]
	scrollArea = CreateFrame("Frame","ScrollArea",mainAddonFrame)
	scrollArea:SetHeight(400)
	scrollArea:SetWidth(660)
	scrollArea:SetPoint("TOPLEFT",10,-10)
	scrollArea:SetBackdrop(
		{ 
	      bgFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
			tile = false, tileSize = 0, edgeSize = 32, 
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		})
	scrollArea:SetBackdropColor(0,1,0,1)
	
	ScrollFrame = CreateFrame("ScrollFrame","ScrollArea",mainAddonFrame)
	ScrollFrame:SetHeight(400)
	ScrollFrame:SetWidth(660)
	ScrollFrame:SetPoint("TOPLEFT",10,-10)
	ScrollFrame:SetBackdrop(
		{ 
	      bgFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
			tile = false, tileSize = 0, edgeSize = 32, 
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		})
	ScrollFrame:SetBackdropColor(0,1,0,1)

	--scrollbar 
	scrollbar = CreateFrame("Slider", nil, ScrollFrame, "UIPanelScrollBarTemplate") 
	scrollbar:SetPoint("TOPLEFT", scrollArea, "TOPRIGHT", 4, -16) 
	scrollbar:SetPoint("BOTTOMLEFT", scrollArea, "BOTTOMRIGHT", 4, 16) 
	scrollbar:SetMinMaxValues(1, 200) 
	scrollbar:SetValueStep(1) 
	scrollbar.scrollStep = 1
	scrollbar:SetValue(0) 
	scrollbar:SetWidth(16) 
	scrollbar:SetScript("OnValueChanged",
		function (self, value) 
			self:GetParent():SetVerticalScroll(value) 
		end
	) 
	local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
	scrollbg:SetAllPoints(scrollbar) 
	-- scrollbg:SetTexture(0, 0.5, 0, 1)
	mainAddonFrame.scrollbar = scrollbar
	print(scrollbar:GetRect())


	--content frame 
	local content = CreateFrame("Frame", nil, ScrollFrame) 
	content:SetSize(660, 1000) 
	local texture = content:CreateTexture() 
	texture:SetAllPoints() 
	texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Gold-Background") 
	content.texture = texture 
	ScrollFrame.content = content 
	 
	ScrollFrame:SetScrollChild(content)
end

