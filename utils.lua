print("Initiating utils")
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
-- utils.logger = logger
print(zorxUtils.logger)

zorxUtils.createDefaultOptions = function ()
    local opts = {}
    opts.ilvlReq = nil
    -- Name must contain one of the strings below.
    opts.nameMatchers = {
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25"
    }
    opts.descriptionMatchers = {
        -- No default description matchers..
    }
    return opts
end
