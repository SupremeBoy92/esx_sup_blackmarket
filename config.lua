Config = {}

Config.Locale       = 'es'

Config.Gangs = {
	"ballas",
	"perico"
}

-- Tiendas

Config.Zones = {
	BlackMarket = {
		Items = {
            --{label = "Pen Drive (Humane)",             item = "pendrive",     price = 10000},
			--{label = "Hacker Device (Yate)",           item = "hackerDevice", price = 10000},
			--{label = "Taladro (Yate)",                 item = "drill",        price = 10000},
			--{label = "Dispositivo de Hackeo (Fleeca)", item = "net_cracker",  price = 5000},
			{label = "Chaleco Ligero",                 item = "armor",        price = 5000},
			
			{label = "Radio",                          item = "radio",        price = 1000},
			{label = "Bolsa",                          item = "headbag",      price = 500},
			{label = "Efedrina",                       item = "efedrina",     price = 10},
			--{label = "Pistola",						   weapon = "pistol",     price = 10},
			
	    },
		Pos = {
			{x = -2166.15,  y = 5197.47, z = 16.88}
		},
		Ped = {
			pedHash = 0x6C19E962,
			seller = {coords = vector3(-2166.15,5197.47,16.88), heading = 100.00},
		},
		Goons = {
			NPC1 = { x = -2181.9467773438, y = 5207.8100585938, z = 20.038946151733, h = 217.13, ped = 'u_m_m_streetart_01', animDict = 'amb@world_human_cop_idles@female@base', animName = 'base', weapon = 'WEAPON_MICROSMG', },
			--NPC2 = { x = -2184.9467773438, y = 5205.6494140625, z = 19.694700241089, h = 217.13, ped = 'u_m_m_streetart_01', animDict = 'rcmme_amanda1', animName = 'stand_loop_cop', weapon = 'WEAPON_MICROSMG', },
			--NPC3 = { x = -2184.9467773430, y = 5205.6494140620, z = 19.694700241089, h = 217.13, ped = 'u_m_m_streetart_01', animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base', animName = 'base', weapon = 'WEAPON_MICROSMG' },
		}
	}
}