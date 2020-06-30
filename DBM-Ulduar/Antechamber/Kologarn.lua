local mod	= DBM:NewMod("Kologarn", "DBM-Ulduar", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4134 $"):sub(12, -3))
mod:SetCreatureID(32930)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat", 32930, 32933, 32934)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	--"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

mod:SetBossHealthInfo(
	32930, L.Health_Body,
	32934, L.Health_Right_Arm,
	32933, L.Health_Left_Arm
)

local warnFocusedEyebeam		= mod:NewTargetAnnounce(63346, 3)
local warnGrip					= mod:NewTargetAnnounce(64292, 2)
local warnCrunchArmor			= mod:NewAnnounce("warnCrunch", 2, 64002, mod:IsTank() or mod:IsHealer())
local warnCrunch10				= mod:NewTargetAnnounce(63355, 2)

local specWarnCrunchArmor2		= mod:NewSpecialWarningStack(64002, nil, 1)
local specWarnEyebeam			= mod:NewSpecialWarningYou(63346)

local timerCrunch10				= mod:NewTargetTimer(6, 63355)
--added
local timerCrunch				= mod:NewTargetTimer(45, 64002, nil, mod:IsTank() or mod:IsHealer())
--

local timerNextOverheadSmash	= mod:NewCDTimer(15, 64003)
local timerNextShockwave		= mod:NewCDTimer(30, 63982)
local timerRespawnLeftArm		= mod:NewTimer(45, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(45, "timerRightArm")
local timerTimeForDisarmed		= mod:NewTimer(12, "achievementDisarmed")	


mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("SetIconOnGripTarget", true)
mod:AddBoolOption("PlaySoundOnEyebeam", true)
mod:AddBoolOption("SetIconOnEyebeamTarget", true)
mod:AddBoolOption("YellOnBeam", true, "announce")
mod:AddBoolOption("SunwellBoost", false)

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 749, "Kologarn")
	if (self.Options.SunwellBoost) then
		timerCrunch10             	= mod:NewTargetTimer(45, 63355)		
	end
	timerNextOverheadSmash:Start(8)
	timerNextOverheadSmash:Schedule(8)
	self:ScheduleMethod(23, "OverheadSmash")
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 749, "Kologarn", wipe)
end

function mod:OverheadSmash()
	timerNextOverheadSmash:Start(28)
	self:ScheduleMethod(28, "OverheadSmash")
end

--function mod:UNIT_DIED(args)
--	if self:GetCIDFromGUID(args.destGUID) == 32934 then 		-- right arm
--		timerRespawnRightArm:Start()
--		timerTimeForDisarmed:Start()
--
--	elseif self:GetCIDFromGUID(args.destGUID) == 32933 then		-- left arm
--		timerRespawnLeftArm:Start()
--		timerTimeForDisarmed:Start()
--	end
--end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(63783, 63982) and args:IsPlayer() then	-- Shockwave
		timerNextShockwave:Start()
	elseif args:IsSpellID(63346, 63976) and args:IsPlayer() then
		specWarnEyebeam:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg:find(L.FocusedEyebeam) then
		self:SendSync("EyeBeamOn", UnitName("player"))
	end
end

function mod:OnSync(msg, target)
	if msg == "EyeBeamOn" then
		warnFocusedEyebeam:Show(target)
		if target == UnitName("player") then
			specWarnEyebeam:Show()
			if self.Options.PlaySoundOnEyebeam then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav") 
			end
			if self.Options.YellOnBeam then
				SendChatMessage(L.YellBeam, "SAY")
			end
		end 
		if self.Options.SetIconOnEyebeamTarget then
			self:SetIcon(target, 5, 8) 
		end
	end
end

local gripTargets = {}
function mod:GripAnnounce()
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	table.wipe(gripTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64290, 64292) then
		if self.Options.SetIconOnGripTarget then
			self:SetIcon(args.destName, 8 - #gripTargets, 10)
		end
		table.insert(gripTargets, args.destName)
		self:UnscheduleMethod("GripAnnounce")
		if #gripTargets >= 3 then
			self:GripAnnounce()
		else
			self:ScheduleMethod(0.2, "GripAnnounce")
		end
	elseif args:IsSpellID(63355) and mod:IsDifficulty("heroic10") then	-- Crunch Armor (10-man)
			warnCrunch10:Show(args.destName)
			timerCrunch10:Start(args.destName)
	elseif args:IsSpellID(64002) and mod:IsDifficulty("heroic25") then -- Crunch Armor (25-man)
			local amount = args.amount or 1
			if args:IsPlayer() and amount >= 1 then
				specWarnCrunchArmor2:Show(amount)
			end
			timerCrunch:Start(args.destName)
			warnCrunchArmor:Show(args.destName, args.destName, args.amount or 1)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(64290, 64292) then
		self:SetIcon(args.destName, 0)
    end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellEncounterStart or msg:find(L.YellEncounterStart)) then --timer for first Shockwave
		timerNextShockwave:Start(18)
	elseif (msg == L.YellLeftArmDies or msg:find(L.YellLeftArmDies)) then  --left arm dies
		timerNextShockwave:Stop()
		timerTimeForDisarmed:Start()
		timerRespawnLeftArm:Start()
	elseif (msg == L.YellRightArmDies or msg:find(L.YellRightArmDies)) then --right arm dies
		timerTimeForDisarmed:Start()
		timerRespawnRightArm:Start()
	end
end