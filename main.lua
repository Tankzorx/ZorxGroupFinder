function main()
	-- SLASH COMMANDS START
	SLASH_ZORX1, SLASH_ZORX2 = '/zorx', '/zorx';
	local function handler(msg, editbox)
		local command, rest = msg:match("^(%S*)%s*(.-)$");
		if command == "open" then
			toggleMainFrame()
		elseif command == "help" then
			print("Try /zorx open")
		else
			toggleMainFrame()
		end

	end
	SlashCmdList["ZORX"] = handler; -- Also a valid assignment strategy
	-- SLASH COMMANDS END

	-- Toggle main frame visibility
	toggleMainFrame = function()
		if mainAddonFrame:IsVisible() then
			mainAddonFrame:Hide()
		else
			mainAddonFrame:Show()
		end
	end

	mainAddonFrame:SetBackdrop({
	      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
	      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
	      tile=1, tileSize=32, edgeSize=32, 
	      insets={left=11, right=12, top=12, bottom=11}
	})
	mainAddonFrame:SetWidth(700)
	mainAddonFrame:SetHeight(600)
	mainAddonFrame:SetPoint("CENTER",UIParent)
	mainAddonFrame:EnableMouse(true)
	mainAddonFrame:SetMovable(true)
	mainAddonFrame:RegisterForDrag("LeftButton")
	mainAddonFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	mainAddonFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	mainAddonFrame:SetFrameStrata("FULLSCREEN_DIALOG")

	closeButton = CreateFrame("button","CloseButton", mainAddonFrame, "UIPanelButtonTemplate")
	closeButton:SetHeight(24)
	closeButton:SetWidth(60)
	closeButton:SetPoint("BOTTOM", mainAddonFrame, "BOTTOM", 310, 10)
	closeButton:SetText("Close")
	closeButton:SetScript("OnClick", function(self)
		print("Clicked Close")
		PlaySound("igMainMenuOption")
		self:GetParent():Hide() 
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



	-- scrollArea.fillerLabel = scrollArea:CreateFontString("FillerLabel","OVERLAY","GameFontNormal")
	-- scrollArea.fillerLabel:SetAllPoints() 
	-- scrollArea.fillerLabel:SetText("|||||||||")
	-- scrollArea.fillerLabel:SetWordWrap(true)
	-- scrollArea.fillerLabel:SetMaxLines(10)
	-- scrollArea.fillerLabel:SetTextHeight(400)
	-- scrollArea:SetVerticalScroll(1000)


	


	-- LFGEntry = CreateFrame("Frame","LFGEntry",ScrollArea)
	-- LFGEntry:SetWidth(680)
	-- LFGEntry:SetHeight(1000)
	-- LFGEntry:SetPoint("TOPLEFT",mainAddonFrame, 10,-10)
	-- LFGEntry:SetBackdropColor(1,0,0);
	-- LFGEntry:SetBackdrop({
	--       bgFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
	--       edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
	--       tile=1, tileSize=32, edgeSize=32, 
	--       insets={left=11, right=12, top=12, bottom=11}
	-- })
	-- /script print(LFGEntry:GetBackdropColor());

	-- myLabel = LFGEntry:CreateFontString("myLavel", "OVERLAY", "GameFontNormal")
	-- myLabel:SetPoint("TOPLEFT", LFGEntry, "TOPLEFT", 10, -10)
	-- myLabel:SetText("MY FUCKING LABEL")
end
	-- --parent frame 
	-- local frame = CreateFrame("Frame", "GroupFinderScrollArea", mainAddonFrame) 
	-- frame:SetSize(660, 400) 
	-- frame:SetPoint("TOPLEFT",10,-10) 
	-- local texture = frame:CreateTexture() 
	-- texture:SetAllPoints() 
	-- -- texture:SetTexture("Interface\\GLUES\\MainMenu\\Glues-BlizzardLogo") 
	-- texture:SetTexture(0,1,0,0.1) 
	-- frame.background = texture 
	 
	-- --scrollframe 
	-- scrollframe = CreateFrame("ScrollFrame", nil, frame) 
	-- scrollframe:SetPoint("TOPLEFT", 10, -10) 
	-- scrollframe:SetPoint("BOTTOMRIGHT", -10, 10) 
	-- local texture = scrollframe:CreateTexture() 
	-- texture:SetAllPoints() 
	-- texture:SetTexture(.2,.2,.2,1) 
	-- frame.scrollframe = scrollframe 
	 
	-- --scrollbar 
	-- scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate") 
	-- scrollbar:SetPoint("TOPLEFT", frame, "TOPRIGHT", 4, -16) 
	-- scrollbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 16) 
	-- scrollbar:SetMinMaxValues(1, 200) 
	-- scrollbar:SetValueStep(1) 
	-- scrollbar.scrollStep = 1
	-- scrollbar:SetValue(0) 
	-- scrollbar:SetWidth(16) 
	-- scrollbar:SetScript("OnValueChanged", 
	-- function (self, value) 
	-- self:GetParent():SetVerticalScroll(value) 
	-- end) 
	-- local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
	-- scrollbg:SetAllPoints(scrollbar) 
	-- scrollbg:SetTexture(0, 0, 0, 0.4) 
	-- frame.scrollbar = scrollbar 
	 
	-- --content frame 
	-- local content = CreateFrame("Frame", nil, scrollframe) 
	-- content:SetSize(640, 128) 
	-- local texture = content:CreateTexture() 
	-- texture:SetAllPoints() 
	-- texture:SetTexture("Interface\\GLUES\\MainMenu\\Glues-BlizzardLogo") 
	-- content.texture = texture 
	-- scrollframe.content = content 
	 
	-- scrollframe:SetScrollChild(content)