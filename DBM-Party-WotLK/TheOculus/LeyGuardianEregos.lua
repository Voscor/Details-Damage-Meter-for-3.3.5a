local mod	= DBM:NewMod("LeyGuardianEregos", "DBM-Party-WotLK", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2481 $"):sub(12, -3))
mod:SetCreatureID(27656)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningShift		= mod:NewSpellAnnounce(51162, 1)
local warningShiftEnd	= mod:NewAnnounce("WarningShiftEnd", 1, 51162)
local warningEnraged	= mod:NewSpellAnnounce(51170, 3)
local timerEnraged		= mod:NewBuffActiveTimer(12, 51170)
local timerShift		= mod:NewBuffActiveTimer(18, 51162)

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 529, "Ley-Guardian Eregos")
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 529, "Ley-Guardian Eregos", wipe)
	if not wipe then
		if DBM.Bars:GetBar(L.MakeitCountTimer) then
			DBM.Bars:CancelBar(L.MakeitCountTimer) 
		end	
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(51162) then
		warningShift:Show()
		warningShiftEnd:Schedule(13)
		timerShift:Start()
	elseif args:IsSpellID(51170) then
		warningEnraged:Show()
		timerEnraged:Start()
	end
end