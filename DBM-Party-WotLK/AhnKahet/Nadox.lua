local mod	= DBM:NewMod("Nadox", "DBM-Party-WotLK", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29309)
mod:SetZone()

mod:RegisterCombat("combat")

local warningPlague	= mod:NewTargetAnnounce(56130, 2)
local timerPlague	= mod:NewTargetTimer(30, 56130)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 580, "Elder Nadox")
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 580, "Elder Nadox", wipe)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(56130, 59467) then
		warningPlague:Show(args.destName)
		timerPlague:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(56130, 59467) then
		timerPlague:Cancel()
	end
end