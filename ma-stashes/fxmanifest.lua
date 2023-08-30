author "donovan0909"
description "Almacenes para inventario de qb"
version "0.0.1"

fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_script 'Config.lua'

client_scripts {
	"Config.lua",
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    "Client/*.lua"
}

dependencies {
    'qb-core',
    'PolyZone'
}
