Damagelog.NamesTable = Damagelog.NamesTable or {}

function Damagelog:GetWeaponName(class)
    return self.NamesTable[class] or TTTLogTranslate(GetDMGLogLang, class, true) or class
end

local function UpdateWeaponNames()
    table.Empty(Damagelog.NamesTable)
    local entsList = {}
    table.Add(entsList, weapons.GetList())
    table.Add(entsList, scripted_ents.GetList())

    for _, v in pairs(entsList) do
        local printName = v.PrintName
        local class = v.ClassName

        Damagelog.NamesTable[class] = printName
    end
end

hook.Add("TTTLanguageChanged", "DL_WeaponNames", UpdateWeaponNames)

-- I kinda missed stupid codes like this
local function GetLangInitFunction()
    local LangInit = LANG.Init

    function LANG.Init(...)
        local res = LangInit(...)
        -- "It ain't stupid if it works", they say
        UpdateWeaponNames()

        return res
    end
end

-- hook.Add("Initialize", "DL_WeaponNames", GetLangInitFunction)