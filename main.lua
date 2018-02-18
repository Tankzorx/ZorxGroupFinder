zorxUtils.logger(5, "Parsing main.lua")
function main()
	-- logger = zorxVar.zorxUtils.logger
	-- SLASH COMMANDS START
	SLASH_ZORX1, SLASH_ZORX2 = '/zorx', '/zorrx';
	local function handler(msg, editbox)
		zorxUtils.logger(4, "Received chat msg: " .. msg)
		local command, rest = msg:match("^(%S*)%s*(.-)$");
		zorxUtils.logger(5, "Command: " .. command)
		zorxUtils.logger(5, "Rest: " .. rest)
		if command == "open" then
			toggleMainFrame()
		elseif command == "help" then
			zorxUtils.logger(4, "Printing help")
			print("Try /zorx open")
		else
			toggleMainFrame()
		end

	end
	SlashCmdList["ZORX"] = handler;

	setupMainFrame(mainAddonFrame);
	initFilter()
end

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