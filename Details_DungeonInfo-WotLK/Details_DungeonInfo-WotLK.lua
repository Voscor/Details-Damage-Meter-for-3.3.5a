local L = LibStub ("AceLocale-3.0")

local _details = 		_G._details

local AhnKahet = {

	id = 523,
	ej_id = 523,
	
	name = "Ahn'Kahet: The Old Kingdom",
	
	boss_names = {
		"Elder Nadox",
		"Prince Taldaram",
		"Amanitar",
		"Jedoga Shadowseeker",
		"Herald Volazj"
	},
	
	boss_ids = {
		[29309] = 1, --nadox
		[29308] = 2, --taldaram
		[30258] = 3, --amanitar
		[29310] = 4, --jedoga
		[29311] = 5  --volazj
	},
	
	encounters = {
		[1] = {
			boss = "Elder Nadox",
			--portrait =
		},
		[2] = {
			boss = "Prince Taldaram",
		},
		[3] = {
			boss = "Amanitar",
		},
		[4] = {
			boss = "Jedoga Shadowseeker",
		},
		[5] = {
			boss = "Herald Volazj",
		},
	},		
}
_details:InstallEncounter (AhnKahet)

local AzjolNerub = {

	id = 534,
	ej_id = 534,
	
	name = "Azjol-Nerub",
	
	boss_names = {
		"Krik'thir the Gatewatcher",
		"Hadronox",
		"Anub'arak"
	},
	
	boss_ids = {
		[28684] = 1, --gatewatcher
		[28921] = 2, --hadronox
		[29120] = 3, --anub
	},
	
	encounters = {
		[1] = {
			boss = "Krik'thir the Gatewatcher",
		},
		[2] = {
			boss = "Hadronox",
		},
		[3] = {
			boss = "Anub'arak",
		},
	},
}
_details:InstallEncounter (AzjolNerub)

local DrakTharon = {

	id = 535,
	ej_id = 535,
	
	name = "Drak'Tharon Keep",
	
	boss_names = {
		"Trollgore",
		"Novos the Summoner",
		"King Dred",
		"The Prophet Tharon'ja",
	},
	
	boss_ids = {
		[26630] = 1, --trollgore
		[26631] = 2, --novos
		[27483] = 3, --king dred
		[26632] = 4, --prophet
	},
	
	encounters = {
		[1] = {
			boss = "Trollgore",
		},
		[2] = {
			boss = "Novos the Summoner",
		},
		[3] = {
			boss = "King Dred",
		},
		[4] = {
			boss = "The Prophet Tharon'ja",
		},
	},
}
_details:InstallEncounter (DrakTharon)

local ForgeofSouls = {

	id = 602,
	ej_id = 602,
	
	name = "Forge of Souls",
	
	boss_names = {
		"Bronjahm",
		"Devourer of Souls",
	},
	
	boss_ids = {
		[36497] = 1, --bronjahm
		[36502] = 2, --devourer
	},
	
	encounters = {
		[1] = {
			boss = "Bronjahm",
		},
		[2] = {
			boss = "Devourer of Souls",
		},
	},
}
_details:InstallEncounter (ForgeofSouls)

local Gundrak = {

	id = 531,
	ej_id = 531,
	
	name = "Gundrak",
	
	boss_names = {
		"Slad'ran",
		"Drakkari Colossus",
		"Moorabi",
		"Eck the Ferocious",
		"Gal'darah",
	},
	
	boss_ids = {
		[29304] = 1, --sladran
		[29307] = 2, --colossus
		[29305] = 3, --moorabi
		[29932] = 4, --eck
		[29306] = 5, --galdarah
	},
	
	encounters = {
		[1] = {
			boss = "Slad'ran",
		},
		[2] = {
			boss = "Drakkari Colossus",
		},
		[3] = {
			boss = "Moorabi",
		},
		[4] = {
			boss = "Eck the Ferocious",
		},
		[5] = {
			boss = "Gal'darah",
		},
	},
}
_details:InstallEncounter (Gundrak)

local HallsofLightning = {

	id = 526,
	ej_id = 526,
	
	name = "Halls of Lightning",
	
	boss_names = {
		"General Bjarngrim",
		"Volkhan",
		"Ionar",
		"Loken",
	},
	
	boss_ids = {
		[28586] = 1, --general
		[28587] = 2, --volkhan
		[28546] = 3, --ionar
		[28923] = 4, --loken
	},
	
	encounters = {
		[1] = {
			boss = "General Bjarngrim",
		},
		[2] = {
			boss = "Volkhan",
		},
		[3] = {
			boss = "Ionar",
		},
		[4] = {
			boss = "Loken",
		},
	},
}
_details:InstallEncounter (HallsofLightning)

local HallsofReflection = {

	id = 604,
	ej_id = 604,
	
	name = "Halls of Reflection",
	
	boss_names = {
		"Falric",
		"Marwyn",
		"Wrath of the Lich King",
	},
	
	boss_ids = {
		[28112] = 1, --falric
		[38113] = 2, --marwyn
		[38113] = 3, --wrath
	},
	
	encounters = {
		[1] = {
			boss = "Falric",
		},
		[2] = {
			boss = "Marwyn",
		},
		[3] = {
			boss = "Wrath of the Lich King",
		},
	},
}
_details:InstallEncounter (HallsofReflection)

local HallsofStone = {
	
	id = 527,
	ej_id = 527,
	
	name = "Halls of Stone",
	
	boss_names = {
		"Krystallus",
		"Maiden of Grief",
		"Tribunal of the Ages",
		"Sjonnir The Ironshaper",
	},
	
	boss_ids = {
		[27977] = 1, --krystallus
		[27975] = 2, --maiden
		[28234] = 3, --tribunal
		[27978] = 4, --sjonnir
	},
	
	encounters = {
		[1] = {
			boss = "Krystallus",
		},
		[2] = {
			boss = "Maiden of Grief",
		},
		[3] = {
			boss = "Tribunal of the Ages",
		},
		[4] = {
			boss = "Sjonnir The Ironshaper",
		},
	},	
}
_details:InstallEncounter (HallsofStone)

local OldStratholme = {

	id = 522,
	ej_id = 522,
	
	name = "The Culling of Stratholme",
	
	boss_names = {
		"Meathook",
		"Salramm the Fleshcrafter",
		"Chrono-Lord Epoch",
		"Infinite Corruptor",
		"Mal'Ganis",
	},
	
	boss_ids = {
		[26529] = 1, --meathook
		[26530] = 2, --salramm
		[26532] = 3, --epoch
		[32273] = 4, --corruptor
		[26533] = 5, --malganis
	},
	
	encounters = {
		[1] = {
			boss = "Meathook",
		},
		[2] = {
			boss = "Salramm the Fleshcrafter",
		},
		[3] = {
			boss = "Chrono-Lord Epoch",
		},
		[4] = {
			boss = "Infinite Corruptor",
		},
		[5] = {
			boss = "Mal'Ganis",
		},
	},
}
_details:InstallEncounter (OldStratholme)

local PitofSaron = {

	id = 603,
	ej_id = 603,
	
	name = "Pit of Saron",
	
	boss_names = {
		"Forgemaster Garfrost",
		"Ick",
		"Krick",
		"Scourgelord Tyrannus",
	},
	
	boss_ids = {
		[36494] = 1, --forgemaster
		[36476] = 2, --ick
		[36477] = 2, --krick
		[36658] = 3, --scourgelord
	},
	
	encounters = {
		[1] = {
			boss = "Forgemaster Garfrost",
		},
		[2] = {
			boss = "Ick & Krick",
		},
		[3] = {
			boss = "Scourgelord Tyrannus",
		},
	},
}
_details:InstallEncounter (PitofSaron)

local TheNexus = {

	id = 521,
	ej_id = 521,
	
	name = "The Nexus",
	
	boss_names = {
		"Commander Kolurg",
		"Commander Stoutbeard",
		"Grand Magus Telestra",
		"Anomalus",
		"Ormorok the Tree-Shaper",
		"Keristrasza"
	},
	
	boss_ids = {
		[26798] = 1, --commander(for alliance)
		[26796] = 1, --commander(for horde)
		[26731] = 2, --grand magus
		[26763] = 3, --anomalus
		[26794] = 4, --ormorok
		[26723] = 5, --keristrasza
	},
	
	encounters = {
		[1] = {
			boss = "Faction Commander",
		},
		[2] = {
			boss = "Grand Magus Telestra",
		},
		[3] = {
			boss = "Anomalus",
		},
		[4] = {
			boss = "Ormorok the Tree-Shaper",
		},
		[5] = {
			boss = "Keristrasza",
		},
	},
}
_details:InstallEncounter (TheNexus)

local TheOculus = {

	id = 529,
	ej_id = 529,
	
	name = "The Oculus",
	
	boss_names = {
		"Drakos the Interrogator",
		"Varos Cloudstrider",
		"Mage-Lord Urom",
		"Ley-Guardian Eregos",
	},
	
	boss_ids = {
		[27654] = 1, --interrogator
		[27447] = 2, --cloudstrider
		[27655] = 3, --mage-lord
		[27656] = 4, --ley-guardian
	},
	
	encounters = {
		[1] = {
			boss = "Drakos the Interrogator",
		},
		[2] = {
			boss = "Varos Cloudstrider",
		},
		[3] = {
			boss = "Mage-Lord Urom",
		},
		[4] = {
			boss = "Ley-Guardian Eregos",
		},
	},
}
_details:InstallEncounter (TheOculus)

local TrialoftheChampion = {

	id = 543,
	ej_id = 543,
	
	name = "Trial of the Champion",
	
	boss_names = {
		"Marshal Jacob Alerius",
		"Ambrose Boltspark",
		"Colosos",
		"Jaelyne Evensong",
		"Lana Stouthammer",
		"Mokra the Skullcrusher",
		"Eressea Dawnsinger",
		"Runok Wildmane",
		"Zul'tore",
		"Deathstalker Visceri",
		"Eadric the Pure",
		"Argent Confessor Paletress",
		"The Black Knight",
	},
	
	boss_ids = {
		--alliance
		[34705] = 1, --warrior
		[34702] = 1, --mage
		[34701] = 1, --shaman
		[34657] = 1, --hunter
		[34703] = 1, --rogue
		--horde
		[35572] = 1, --warrior
		[35569] = 1, --mage
		[35571] = 1, --shaman
		[35570] = 1, --hunter
		[35617] = 1, --rogue
		
		[35119] = 2, --eadric
		[34928] = 3, --confessor
		[35451] = 4, --black knight
	},
	
	encounters = {
		[1] = {
			boss = "Faction Champions",
		},
		[2] = {
			boss = "Eadric the Pure",
		},
		[3] = {
			boss = "Argent Confessor Paletress",
		},
	},
}
_details:InstallEncounter (TrialoftheChampion)

local UtgardeKeep = {

	id = 524,
	ej_id = 524,
	
	name = "Utgarde Keep",
	
	boss_names = {
		"Prince Keleseth",
		"Skarvald the Constructor",
		"Dalronn the Controller",
		"Ingvar the Plunderer",
	},
	
	boss_ids = {
		[23953] = 1, --prince
		[24200] = 2, --constructor
		[24201] = 2, --controller
		[23954] = 3, --plunderer
	},
	
	encounters = {
		[1] = {
			boss = "Prince Keleseth",
		},
		[2] = {
			boss = "Skarvald the Constructor & Dalronn the Controller",
		},
		[3] = {
			boss = "Ingvar the Plunderer",
		},
	},
}
_details:InstallEncounter (UtgardeKeep)

local UtgardePinnacle = {

	id = 525,
	ej_id = 525,
	
	name = "Utgarde Pinnacle",
	
	boss_names = {
		"Svala Sorrowgrave",
		"Gortok Palehoof",
		"Skadi the Ruthless",
		"King Ymiron",
	},
	
	boss_ids = {
		[26668] = 1, --svala
		[26687] = 2, --gortok
		[26693] = 3, --skadi
		[26861] = 4, --ymiron
	},
	
	encounters = {
		[1] = {
			boss = "Svala Sorrowgrave",
		},
		[2] = {
			boss = "Gortok Palehoof",
		},
		[3] = {
			boss = "Skadi the Ruthless",
		},
		[4] = {
			boss = "King Ymiron",
		},
	},
}
_details:InstallEncounter (UtgardePinnacle)

local VioletHold = {
	
	id = 537,
	ej_id = 537,
	
	name = "The Violet Hold",
	
	boss_names = {
		"Erekem",
		"Moragg",
		"Ichoron",
		"Xevozz",
		"Lavanthor",
		"Zuramat the Obliterator",
		"Cyanigosa",
	},
	
	boss_ids = {
		[29315] = 1, --erekem
		[29316] = 2, --moragg
		[29313] = 3, --ichoron
		[29266] = 4, --xevozz
		[29312] = 5, --lavanthor
		[29314] = 6, --zuramat
		[31134] = 7, --cyanigosa
	},
	
	encounters = {
		[1] = {
			boss = "Erekem",
		},
		[2] = {
			boss = "Moragg",
		},
		[3] = {
			boss = "Ichoron",
		},
		[4] = {
			boss = "Xevozz",
		},
		[5] = {
			boss = "Lavanthor",
		},
		[6] = {
			boss = "Zuramat the Obliterator",
		},
		[7] = {
			boss = "Cyanigosa",
		},
	},
}
_details:InstallEncounter (VioletHold)