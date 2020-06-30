local mod	= DBM:NewMod("Thorim", "DBM-Ulduar", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4177 $"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetUsedIcons(8)

mod:RegisterCombat("yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_CAST_START"
)

local warnPhase2				= mod:NewPhaseAnnounce(2, 1)
local warnStormhammer			= mod:NewTargetAnnounce(62470, 2)
local warnLightningCharge		= mod:NewSpellAnnounce(62279, 2)
local warnUnbalancingStrike		= mod:NewTargetAnnounce(62130, 4)
local warningBomb				= mod:NewTargetAnnounce(62526, 4)

local specWarnOrb				= mod:NewSpecialWarningMove(62017)


local enrageTimer				= mod:NewBerserkTimer(300)
local timerStormhammer			= mod:NewCastTimer(16, 62042)
local timerStormhammerCD		= mod:NewCDTimer(14, 62042) 
local timerLightningCharge	 	= mod:NewCDTimer(10, 62279) 
local timerUnbalancingStrike	= mod:NewCDTimer(20, 62130)
local timerHardmode				= mod:NewTimer(150, "TimerHardmode", 62042)
local timerFrostNova			= mod:NewNextTimer(20, 62605)
local timerFrostNovaCast		= mod:NewCastTimer(2.5, 62605)
local timerChainLightning		= mod:NewNextTimer(15, 64390)
local timerFBVolley				= mod:NewCDTimer(13, 62604)

mod:AddBoolOption("RangeFrame")

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 752, "Thorim")

end

function mod:OnCombatEnd()
	DBM:FireCustomEvent("DBM_EncounterEnd", 752, "Thorim", wipe)
	DBM.BossHealth:Hide()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if (timerHardmode ~= nil) then
		timerHardmode:Stop()
	end
	if (enrageTimer ~= nil) then
		enrageTimer:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62042) then 					-- Storm Hammer
		warnStormhammer:Show(args.destName)
		timerStormhammerCD:Start()
	elseif args:IsSpellID(62507) then				-- Touch of Dominion
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
		timerHardmode:Start()
		enrageTimer:Start()
	elseif args:IsSpellID(62130) then				-- Unbalancing Strike
		warnUnbalancingStrike:Show(args.destName)
	elseif args:IsSpellID(62526, 62527) then		-- Runic Detonation
		self:SetIcon(args.destName, 8, 5)
		warningBomb:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62042) then 		-- Storm Hammer
		timerStormhammerCD:Start()
		timerStormhammer:Schedule(2)
	elseif args:IsSpellID(62130) then	-- Unbalancing Strike
		timerUnbalancingStrike:Start()
	elseif args:IsSpellID(62604) then	-- Frostbolt Volley by Sif
		timerFBVolley:Start()
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then		-- Bossfight (tank and spank)
		warnPhase2:Show()
		timerStormhammerCD:Stop()
		enrageTimer:Stop()
		if (timerHardmode ~= nil) then
			timerHardmode:Stop()
		end
	elseif msg == L.YellKill or msg == L.YellFail or msg:find(L.YellKill) then
		self:ScheduleMethod(1, "OnCombatEnd")
	end
end

local spam = 0

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(62017) then -- Lightning Shock
		if bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0
		and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		and GetTime() - spam > 5 then
			spam = GetTime()
			specWarnOrb:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62605) then --Frost Nova by Sif
		timerFrostNovaCast:Start()
		timerFrostNova:Start()
	elseif args:IsSpellID(64390) then --Chain Lightning by Thorim
		timerChainLightning:Start()
	end
end