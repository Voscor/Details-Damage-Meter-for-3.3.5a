local mod	= DBM:NewMod("Razorscale", "DBM-Ulduar", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4133 $"):sub(12, -3))
mod:SetCreatureID(33186)
mod:SetUsedIcons(8)

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellAir)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"UNIT_TARGET",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnTurretsReadySoon			= mod:NewAnnounce("warnTurretsReadySoon", 1, 48642)
local warnTurretsReady				= mod:NewAnnounce("warnTurretsReady", 3, 48642)
local warnDevouringFlameCast		= mod:NewAnnounce("WarnDevouringFlameCast", 2, 64733, false, "OptionDevouringFlame") -- new option is just a work-around...the saved variable handling will be updated to allow changing and updating default values soon
local warnFuseArmor					= mod:NewAnnounce("warnFuseArmor", 2, 64771, mod:IsTank() or mod:IsHealer())
local specWarnFuseArmor				= mod:NewSpecialWarningStack(64771, nil, 2)
local timerFuseArmor				= mod:NewTargetTimer(20, 64771, nil, mod:IsTank() or mod:IsHealer())

local specWarnDevouringFlame		= mod:NewSpecialWarningMove(64733)
local specWarnDevouringFlameCast	= mod:NewSpecialWarning("SpecWarnDevouringFlameCast")

local timerDeepBreathCooldown		= mod:NewCDTimer(15, 64021)
local timerDeepBreathCast			= mod:NewCastTimer(2.5, 64021)
local timerTurret1					= mod:NewTimer(54, "timerTurret1", 48642)
local timerTurret2					= mod:NewTimer(74, "timerTurret2", 48642)
local timerTurret3					= mod:NewTimer(93, "timerTurret3", 48642)
local timerTurret4					= mod:NewTimer(113, "timerTurret4", 48642)
local timerGrounded                 = mod:NewTimer(35, "timerGrounded")

mod:AddBoolOption("PlaySoundOnDevouringFlame", false)
mod:AddBoolOption("SunwellBoost", false)

local enrageTimer = 0
local castFlames
local combattime = 0

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 746, "Razorscale")
	combattime = GetTime()
	if mod:IsDifficulty("heroic25") then
		if (self.Options.SunwellBoost) then
			enrageTimer = mod:NewBerserkTimer(420)
		else
			enrageTimer = mod:NewBerserkTimer(600)
		end
		enrageTimer:Start()
		warnTurretsReadySoon:Schedule(94)
		warnTurretsReady:Schedule(114)
		timerTurret1:Start() 
		timerTurret2:Start() 
		timerTurret3:Start() 
		timerTurret4:Start() 
	else
		enrageTimer = mod:NewBerserkTimer(600)
		enrageTimer:Start()
		warnTurretsReadySoon:Schedule(54)
		warnTurretsReady:Schedule(74)
		timerTurret1:Start()
		timerTurret2:Start()
	end
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 746, "Razorscale", wipe)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64771) then
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 2 then
			specWarnFuseArmor:Show(amount)
		end
		timerFuseArmor:Start(args.destName)
		warnFuseArmor:Show(args.destName, args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(64733, 64704) and args:IsPlayer() then
		specWarnDevouringFlame:Show()
		if self.Options.PlaySoundOnDevouringFlame then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end		
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmotePhase2 or emote:find(L.EmotePhase2) then
		-- phase2
		timerTurret1:Stop()
		timerTurret2:Stop()
		timerTurret3:Stop()
		timerTurret4:Stop()
		timerGrounded:Stop()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	if (msg == L.YellAir or msg == L.YellAir2) and GetTime() - combattime > 30 then
		if mod:IsDifficulty("heroic10") then
			warnTurretsReadySoon:Schedule(51)
			warnTurretsReady:Schedule(71)
			timerTurret1:Start(51)
			timerTurret2:Start(71)
		else
			warnTurretsReadySoon:Schedule(94)
			warnTurretsReady:Schedule(114)
			timerTurret1:Start(54)
			timerTurret2:Start(74)
			timerTurret3:Start(94)
			timerTurret4:Start(114)
		end

	elseif msg == L.YellGround then
		timerGrounded:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64021) then	-- deep breath
		timerDeepBreathCast:Start()
		timerDeepBreathCooldown:Start()
	elseif args:IsSpellID(63236) then
		local target = self:GetBossTarget(self.creatureId)
		if target then
			self:CastFlame(target)
		else
			castFlames = GetTime()
		end
	end
end

function mod:UNIT_TARGET(unit)	-- I think this is useless, why would anyone in the raid target razorflame right after the flame stuff?
	if castFlames and GetTime() - castFlames <= 1 and self:GetUnitCreatureId(unit.."target") == self.creatureId then
		local target = UnitName(unit.."targettarget")
		if target then
			self:CastFlame(target)
		else
			self:CastFlame(L.FlamecastUnknown)
		end
		castFlames = false
	end
end 

function mod:CastFlame(target)
	warnDevouringFlameCast:Show(target)
	if target == UnitName("player") then
		specWarnDevouringFlameCast:Show()
	end
	self:SetIcon(target, 8, 9)
end 