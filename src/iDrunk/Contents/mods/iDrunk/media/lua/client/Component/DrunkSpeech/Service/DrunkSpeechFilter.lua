local json = require 'Component/Json/Json'

local rules = json.decode(string.gsub(getText('UI_DrunkSpeech_Dictionary_Filter'), '*', ''))
local caseRules = json.decode(string.gsub(getText('UI_DrunkSpeech_Dictionary_Case_Filter'), '*', ''))

local function insertChar(subject, string, position)
    return subject:sub(1, position) .. string .. subject:sub(position + 1)
end

local function replaceChar(position, replace, subject)
    return replace:sub(1, position - 1) .. subject .. replace:sub(position + 1)
end

local function in_table(e, t)
    for _, v in pairs(t) do
        if (v == e) then
            return true
        end
    end

    return false
end

DrunkSpeechFilter = {}
function DrunkSpeechFilter:filter(message)
    local drunkenness = getPlayer():getStats():getDrunkenness()
    local needChanceToModify = 100

    if drunkenness >= 10 and drunkenness < 30 then
        needChanceToModify = 90
    elseif drunkenness >= 30 and drunkenness < 50 then
        needChanceToModify = 85
    elseif drunkenness >= 50 and drunkenness < 70 then
        needChanceToModify = 80
    elseif drunkenness >= 70 then
        needChanceToModify = 75
    end

    for i = 1, #message do
        local currentChar = message:sub(i, i)
        for _, rule in pairs(rules) do
            if in_table(currentChar, rule.needle) then
                if rule.add ~= nil then
                    if rule.add.before ~= nil then
                        if ZombRand(1, 100) > needChanceToModify then
                            local chars = rule.add.before
                            local newChar = rule.add.before[ZombRand(1, #chars)]
                            message = insertChar(message, newChar, i)
                            i = i + #newChar - 1
                        end
                    end

                    if rule.add.after ~= nil then
                        if ZombRand(1, 100) > needChanceToModify then
                            local chars = rule.add.after
                            local newChar = rule.add.after[ZombRand(1, #chars)]
                            message = insertChar(message, newChar, i)
                            i = i + #newChar - 1
                        end
                    end
                end

                if rule.replace ~= nil then
                    if rule.replace.full ~= nil then
                        if ZombRand(1, 100) > needChanceToModify then
                            local chars = rule.replace.full
                            local newChar = rule.replace.full[ZombRand(1, #chars)]
                            message = replaceChar(i, message, newChar)
                            i = i + #newChar - 1
                        end
                    end
                end
            end
        end
    end

    for i = 1, #message do
        local char = message:sub(i, i)
        if caseRules[char] ~= nil then
            if ZombRand(1, 100) > needChanceToModify then
                message = replaceChar(i, message, caseRules[char])
            end
        end
    end

    return message
end

local onCommandEntered = ISChat.onCommandEntered
function ISChat:onCommandEntered()
    local command, text = string.match(ISChat.instance.textEntry:getText(), '(/%a+)%s+(.*)')
    ISChat.instance.textEntry:setText(command .. ' ' .. DrunkSpeechFilter:filter(text))
    onCommandEntered(self)
end
