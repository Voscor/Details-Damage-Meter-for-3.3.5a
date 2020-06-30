local mod	= DBM:NewMod("GortokPalehoof", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(26687)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningImpale		= mod:NewTargetAnnounce(48261, 2)
local timerImpale		= mod:NewTargetTimer(9, 48261)

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 525, "Gortok Palehoof")
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 525, "Gortok Palehoof", wipe)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(48261, 59268) then
		warningImpale:Show(args.destName)
		timerImpale:Start(args.destName)
	end
end