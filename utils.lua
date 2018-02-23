-- print("Initiating utils")
--[[ LOGGING
	5 = VERBOSSSEEEE
    4 = INFO
    3 = TBD
    2 = ERROR
    1 = OFF
	]]
zorxUtils.logger = function (logLevel, msg)
    if logLevel <= zorxLogLevel then
        if logLevel == 5 then
            print("[VERB]" .. msg)
        elseif logLevel == 4 then
            print("[INFO]" .. msg)
        elseif logLevel == 3 then
            print("[TBD]" .. msg)
        elseif logLevel == 2 then
            print("[ERRO]" .. msg)
		end
	end
end

zorxUtils.createDefaultOptions = function ()
    local opts = {}
    -- opts.ilvlReq = 960
    -- Name must contain one of the strings below.
    opts.nameMatchers = {
        -- "16",
        -- "21"
    }
    opts.minHealerCount = 0
    opts.maxHealerCount = 5
    opts.minTankCount = 0
    opts.maxTankCount = 5
    opts.minDpsCount = 0
    opts.maxDpsCount = 5
    opts.descMatchers = {
        -- No default description matchers..
        "hi"
    }
    opts.filteringEnabled = true
    return opts
end

