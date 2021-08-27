fx_version 'cerulean'
game 'gta5'

client_scripts { 
    
    'client/cl_functions.lua',
    'client/cl_events.lua',
    'client/cl_main.lua'

} 

server_scripts {

    'server/sv_functions.lua',
    'server/sv_events.lua',
    'server/sv_server.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/assets/*.png'
}
