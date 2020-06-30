local mod	= DBM:NewMod("Eck", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2869 $"):sub(12, -3))
mod:SetCreatureID(29932)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

local enrageTimer	= mod:NewBerserkTimer(120)

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 531, "Eck the Ferocious")
	enrageTimer:Start(120 - delay)
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 531, "Eck the Ferocious", wipe)
end