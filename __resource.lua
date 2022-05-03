resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Supreme BlackMarket'
author 'SupremeBoy#2186'

version '1.0'

server_scripts {
  '@es_extended/locale.lua',
  'locales/*.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/*.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/*.lua',
  'config.lua',
  'client/*.lua'
}
