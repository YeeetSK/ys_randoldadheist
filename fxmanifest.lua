fx_version "cerulean"
game "gta5"
lua54 'yes'

author 'Snowly, Redacted, Yeet and obviously Randolio Dad'
description 'Script for Randolios dad to come back'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

escrow_ignore {
    'config.lua'
}
