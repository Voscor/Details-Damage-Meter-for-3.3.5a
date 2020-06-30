local mod	= DBM:NewMod("Gluth", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2869 $"):sub(12, -3))
mod:SetCreatureID(15932)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_DAMAGE",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)
-------
--TODO: Check if default value has to be from 25m to work on Heigan // May stop working on Gluth
-------	Test difficulty dependencies affecting proper wound duration
local warnDecimateSoon	= mod:NewSoonAnnounce(54426, 2)
local warnDecimateNow	= mod:NewSpellAnnounce(54426, 3)
local warnEnraged		= mod:NewSpellAnnounce(54427, 3)

local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5)
local warnWound			= mod:NewAnnounce("WarnMortalWound", 2, 25646, mod:IsTank() or mod:IsHealer())
--local timerWound		= mod:NewTargetTimer(8, 25646)

local timerDecimate		= mod:NewCDTimer(105, 54426)
local timerEnrage		= mod:NewCDTimer(30, 54427, nil, mod:CanRemoveEnrage())
local timerEnraged		= mod:NewTimer(8, "TimerEnraged", 54427, mod:CanRemoveEnrage())
--original one, w/o announcing stacks and w/o difficulty dependencies
--local timerWound		= mod:NewCDTimer(8, 25646, nil, mod:IsTank())

local lastEnrage		 
local timerWound = nil

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 698, "Gluth")
	if mod:IsDifficulty("heroic25") then
		timerWound		= mod:NewTargetTimer(40, 25646, nil, mod:IsTank() or mod:IsHealer())
	else
		timerWound		= mod:NewTargetTimer(15, 25646, nil, mod:IsTank() or mod:IsHealer())
	end
	lastEnrage = nil
	timerDecimate:Start(105 - delay)
	warnDecimateSoon:Schedule(95 - delay)
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 698, "Gluth", wipe)
end

local decimateSpam = 0
function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(28375) and (GetTime() - decimateSpam) > 20 then
		decimateSpam = GetTime()
		warnDecimateNow:Show()
		timerDecimate:Start()
		warnDecimateSoon:Schedule(96)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(54427, 28371) then
		warnEnraged:Show()
		lastEnrage = GetTime()
		timerEnraged:Start()
--added
	elseif args:IsSpellID(25646) then
		warnWound:Show(args.spellName, args.destName, args.amount or 1)
		timerWound:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 5 then
			specWarnWound:Show(args.amount)
		end
	end
-------
end
--added
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
-------
function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(54427, 28371) then
		timerEnraged:Stop()
		timerEnrage:Start(30-(GetTime()-lastEnrage))
	end
end

---Original Mortal Wound handling code
--function mod:SPELL_CAST_SUCCESS(args)
--	if args:IsSpellID(25646) then
	--	timerWound:Start()
--	end
--end