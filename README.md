# Local AI Inference Server for jan.ai & llama.cpp (MacOS) Documentation

This plugin was primarily made to make managing your Jan AI Inference local servers easier. It 
is possible to manage an local model server via the Jan app, but if you want to minimize your memory footprint
or prefer not having to use the app every time, that leaves you with the Jan CLI. So instead of having 
to run the same commands over and over in the Jan CLI when you want to use your server, this plugin 
serves as a menu to start, stop, and manage your server, along with it's log files, at the click of a button. 
For security, you set up your own API key stored in MacOS's Keychain, which makes sure that only you are able 
to access your model (which massively reduces the risk of malicious software or websites accessing your running models!); 
all combined into a small, memory/performance-friendly package!

**SETUP** (This assumes you have already installed SwiftBar and have a plugin directory set!):
1. Install the Jan App first, if you haven't already. You will need it for initial setup; but once your models are installed
   and configured, you won't need it anymore.
2. Install the Jan CLI once the app is configured. You will find the install instructions in Jan settings.
3. Run the 'setup-jan-api-key.sh' once to create or store your API key in Keychain, it will be used to validate access 
   to your local models for security reasons. 
4. Place the 'jan_api.10s.command' file in your SwiftBar plugins folder.
5. The plugin should be visible in your menu bar.
6. Once the plugin is successfully activated, you can configure and monitor your server from 
   the menu bar as opposed to the Jan app or command-line.
7. To view the log files (which are written every time the server is started or killed) go to the location below. 

**LOG FILE**: /tmp/jan-api-server.log
