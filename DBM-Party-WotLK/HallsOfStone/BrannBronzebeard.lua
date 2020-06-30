local mod	= DBM:NewMod("BrannBronzebeard", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4282 $"):sub(12, -3))
mod:SetCreatureID(28070)
--mod:SetZone()
mod:SetMinSyncRevision(2861)

mod:RegisterCombat("yell", L.Pull)
mod:RegisterKill("yell", L.Kill)
mod:SetMinCombatTime(50)
mod:SetWipeTime(25)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warningPhase	= mod:NewAnnounce("WarningPhase", 2, "Interface\\Icons\\Spell_Nature_WispSplode")
local timerEvent	= mod:NewTimer(302, "timerEvent", "Interface\\Icons\\Spell_Holy_BorrowedTime")
local timerWave1	= mod:NewTimer(4, "timerWave1")
local timerWave2	= mod:NewTimer(49, "timerWave2")
local timerWave3	= mod:NewTimer(91, "timerWave3")
local timerWave4	= mod:NewTimer(131, "timerWave4")
local timerWave5	= mod:NewTimer(169,	"timerWave5")
local timerWave6	= mod:NewTimer(204, "timerWave6")
local timerWave7	= mod:NewTimer(236, "timerWave7")
local timerWave8	= mod:NewTimer(266,	"timerWave8")

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 527, "Tribunal of the Ages")
	timerEvent:Start(-delay)
	timerWave1:Start(-delay)
	timerWave2:Start(-delay)
	timerWave3:Start(-delay)
	timerWave4:Start(-delay)
	timerWave5:Start(-delay)
	timerWave6:Start(-delay)
	timerWave7:Start(-delay)
	timerWave8:Start(-delay)
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 527, "Tribunal of the Ages", wipe)
end

function mod:CHAT_MSG_MONSTER_YELL(msg, sender)
	if L.Phase1 == msg then
		warningPhase:Show(1)
	elseif msg == L.Phase2 then
		warningPhase:Show(2)
	elseif msg == L.Phase3 then
		warningPhase:Show(3)
	end
end


