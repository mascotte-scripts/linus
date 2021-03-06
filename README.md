![image](https://i.imgur.com/DOK4eUD.png)

## [FAQ](/faq.md) | [Installation](/install.md) | [Client Docs](/client/cl_commands.md) | [Server Docs](/server/sv_commands.md)

# This is not a full release. A lot of stuff like character deletion and some NUI data isn't yet working. This is stuff we're aware of, but not considering a priority just as of yet considering this is a Work In Progress

# Linus Framework [Work In Progress]
Linus is a lightweight & user friendly roleplaying framework for FiveM. It is the first FiveM framework of it's kind to be completely independent of any 3rd party dependencies such as using a mySQL database. The user-friendly layout and code modulation of Linus makes it simple to navigate and make changes to, regardless of coding skill. Development commenced on the project in early summer 2021, by Mascotte45 & NotSomething0 - however, many many people have contributed to this project since it's conception, whether be it directly or indirectly (Refer to Notes section for full list of noted contributions)

# Installation

- Download the latest release from the side tab, and extract the folder 'linus' and it's contents to your resource folder.
- Rename the resource from `linus-alpha-0.01` to whatever you like. However, changing the resource name will cause issues with the kvp storage, so it's recommended to only change the resource name once.
- Alternatively, clone the repo using `https://github.com/mascotte-scripts/linus.git`
- Copy `valkyrie.cfg, LinusConfig.cfg, LinusPerms.cfg` from the linus folder to the same folder as `server.cfg` 
- Add to server.cfg: 
`exec valkyrie.cfg
exec LinusConfig.cfg
exec LinusPerms.cfg`
- FiveM appearance is not currently modulated, you will need to run this resource separately

## Dependencies

None

# To-Do List (Updated Soon)

- Fix Current Issues
- Create Inventory System
- Attempt to improve the native weapon loadout functionality
- Stats
- Donator/VIP functionality for server owners?
- Modules such as jobs, weather and time sync - dynamic weather, etc
- Version check for modules

# Current Issues
To be updated

# Notes
## Contributors & Kudos

[Mascotte45](https://github.com/mascotte-scripts) - Project Co-Leader<br/>
[NotSomething0](https://github.com/NotSomething0) - Project Co-Leader / Valkyrie Creator<br/>
[Dislaik](https://github.com/Dislaik) - Permitted use of his framework modulation format - As seen in his framework: `Zombie Outbreak`<br/>
[pedr0fontoura](https://github.com/pedr0fontoura) - Framework partially inspired by (And uses) his resource `fivem-appearance`<br/>
[PiterMcFlebor](https://github.com/pitermcflebor) - Framework uses his `pmc-callbacks` script<br/>
[cfx.re](https://github.com/citizenfx) - Their player data resource made the project possible from having practical examples of kvp useage and identifier caching<br/>
[Re-Ignited](https://discord.gg/FVJtvh3YMK) - Framework support

# Wiki
[https://mascotte-scripts.github.io/](https://mascotte-scripts.github.io/)
