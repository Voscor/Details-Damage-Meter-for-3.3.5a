local mod	= DBM:NewMod("Heigan", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2248 $"):sub(12, -3))
mod:SetCreatureID(15936)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)
--TODO: Test timerWound target timer duration (1st argument)
local warnTeleportSoon	= mod:NewAnnounce("WarningTeleportSoon", 2, 46573)
local warnTeleportNow	= mod:NewAnnounce("WarningTeleportNow", 3, 46573)

local timerTeleport		= mod:NewTimer(90, "TimerTeleport", 46573)
--added
local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5)
local warnWound			= mod:NewAnnounce("WarningMortalWound", 2, 25646, mod:IsTank() or mod:IsHealer())
local timerWound		= mod:NewTargetTimer(40, 25646, nil, mod:IsTank() or mod:IsHealer())
-------
function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 683, "Heigan the Unclean")
	mod:BackInRoom(90 - delay)
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 683, "Heigan the Unclean", wipe)
end

function mod:DancePhase()
	timerTeleport:Show(47)
	warnTeleportSoon:Schedule(37, 10)
	warnTeleportNow:Schedule(47)
	self:ScheduleMethod(47, "BackInRoom", 88)
end

function mod:BackInRoom(time)
	timerTeleport:Show(time)
	warnTeleportSoon:Schedule(time - 15, 15)
	warnTeleportNow:Schedule(time)
	self:ScheduleMethod(time, "DancePhase")
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED --Proper display of Mortal Wound stacks
-----------------------------------------------------------------------------------------------------------------------------------------------
--Mortal Wound ability handled on Heigan - duplicating the function here makes it so it is executed twice since they both use the same spall ID
-----------------------------------------------------------------------------------------------------------------------------------------------
--function mod:SPELL_CAST_SUCCESS(args)
--function mod:SPELL_AURA_APPLIED(args)
--	if args:IsSpellID(25646) then
	--test start
--		warnWound:Show(args.spellName, args.destName, args.amount or 1)
--		timerWound:Start(args.destName)
--		if args:IsPlayer() and (args.amount or 1) >= 5 then
--			specWarnWound:Show(args.amount)
--		end
	--test end
	--	timerWound:Start()
--	end
--end

