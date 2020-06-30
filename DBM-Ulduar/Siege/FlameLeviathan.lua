local mod	= DBM:NewMod("FlameLeviathan", "DBM-Ulduar", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4181 $"):sub(12, -3))

mod:SetCreatureID(33113)

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_APPLIED",
	"SPELL_SUMMON"
)

local warnHodirsFury		= mod:NewTargetAnnounce(62297)
local pursueTargetWarn		= mod:NewAnnounce("PursueWarn", 2, 62374)
local warnNextPursueSoon	= mod:NewAnnounce("warnNextPursueSoon", 3, 62374)

local warnSystemOverload	= mod:NewSpecialWarningSpell(62475)
local pursueSpecWarn		= mod:NewSpecialWarning("SpecialPursueWarnYou")
local warnWardofLife		= mod:NewSpecialWarning("warnWardofLife")

local timerSystemOverload	= mod:NewBuffActiveTimer(20, 62475)
local timerFlameVents		= mod:NewCastTimer(10, 62396)
local timerPursued			= mod:NewTimer(30, "TimerPursued", 62374)
local timerFirstPlants		= mod:NewTimer(34, "TimerPlants", 62907)
local timerPlants			= mod:NewTimer(29, "TimerPlants", 62907)

local soundPursued 			= mod:NewSound(62374)

local guids = {}

local function buildGuidTable()
	table.wipe(guids)							  
	for i = 1, GetNumRaidMembers() do
		guids[UnitGUID("raid"..i.."pet") or ""] = UnitName("raid"..i)
	end
end

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 744, "Flame Leviathan")
	buildGuidTable()
	timerFirstPlants:Start()
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 744, "Flame Leviathan", wipe)
end

local spam = 0

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(62907) and GetTime() - spam > 5 then		-- Ward of Life spawned (Creature id: 34275)
		spam = GetTime()
		warnWardofLife:Show()
		timerPlants:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62396) then		-- Flame Vents
		timerFlameVents:Start()

	elseif args:IsSpellID(62475) then	-- Systems Shutdown / Overload
		timerSystemOverload:Start()
		warnSystemOverload:Show()
		if timerPursued ~= nil then
			timerPursued:AddTime(20)
		end
		if timerFirstPlants ~= nil then
			timerFirstPlants:AddTime(20)
		end

	elseif args:IsSpellID(62374) then	-- Pursued
		local player = guids[args.destGUID]
		warnNextPursueSoon:Schedule(25)
		timerPursued:Start(player)
		pursueTargetWarn:Show(player)
		if player == UnitName("player") then
			pursueSpecWarn:Show()
			soundPursued:Play()
		end
		
	elseif args:IsSpellID(62297) then		-- Hodir's Fury (Person is frozen)
		warnHodirsFury:Show(args.destName)
	
	elseif args:IsSpellID(64482) then		-- Tower of Life (Plant Spawn)
		timerPlants:Start(34)
	end
end


function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(62396) then
		timerFlameVents:Stop()
	end
end