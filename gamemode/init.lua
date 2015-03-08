
/*----------------------------------------------------------------------------------
	Made by Robbert de Jel, coyprighted by Robbert de Jel - All rights reserved.
	
	
*/-----------------------------------------------------------------------------------
AddCSLuaFile( "cl_init.lua" )  
AddCSLuaFile( "client/cl_classmenu.lua" )
AddCSLuaFile( "client/cl_hud.lua" )
AddCSLuaFile( "client/cl_killfeed.lua" )
AddCSLuaFile( "client/cl_options.lua" )
AddCSLuaFile( "client/cl_timers.lua" )
AddCSLuaFile( "client/object_player_exstended_cl.lua" )
AddCSLuaFile( "client/cl_colorcorrection.lua" )
AddCSLuaFile( "shared.lua" )       
AddCSLuaFile( "shared/options_shared.lua" )
AddCSLuaFile( "shared/sh_zombieanimations.lua" )
AddCSLuaFile( "shared/sh_object_player_exstended.lua" )
AddCSLuaFile( "shared/sh_obj_entity_exstended.lua" )
AddCSLuaFile( "server/sv_classes.lua" )
AddCSLuaFile( "server/sv_takedamage.lua" )
AddCSLuaFile( "server/obj_weapon_exstended.lua" )
AddCSLuaFile( "server/obj_entity_exctended.lua" )
AddCSLuaFile( "server/sv_savedata.lua" )
AddCSLuaFile( "server/sv_weaponpickup.lua" )
AddCSLuaFile( "server/sv_cratehandeler.lua" )
AddCSLuaFile( "server/obj_player.exstended.lua" )
AddCSLuaFile( "server/sv_weaponskins.lua" )
AddCSLuaFile( "server/sv_roundsystem.lua" )
AddCSLuaFile( "server/sv_deathhandeler.lua" )
AddCSLuaFile( "client/splitmessage.lua" )
AddCSLuaFile( "client/cl_weapon_selection.lua" )
AddCSLuaFile( "client/cl_scoreboard.lua" )
AddCSLuaFile( "client/cl_targetid.lua" )

include( "shared/options_shared.lua" )
include( "server/sv_takedamage.lua" )
include( "server/obj_player.exstended.lua" )
include( "server/obj_entity_exctended.lua" )                         
include( "server/sv_weaponskins.lua" )                          
include( "server/sv_savedata.lua" )                           
include( "server/sv_cratehandeler.lua" )                           
include( "server/sv_classes.lua" ) 
include( "server/sv_weaponpickup.lua" ) 
include( "server/sv_deathhandeler.lua" ) 
include( "shared.lua" )
include( "server/sv_roundsystem.lua" )

function GM:Initialize( pl )
	resource.AddFile("materials/sprites/scope.vmt")
	resource.AddFile("materials/sprites/scope.vtf")
	resource.AddFile("materials/pupulet/pupulet_pentagram.vmt")
	resource.AddFile("materials/pupulet/pupulet_pentagram.vtf")
	resource.AddFile("materials/hud3/hud_warning1.vmt")
	resource.AddFile("materials/hud3/hud_warning1.vtf")
	resource.AddFile("materials/hud3/hud_flashlight.vmt")
	resource.AddFile("materials/hud3/hud_flashlight.vtf")
	resource.AddFile("materials/hud3/hud_warning2.vmt")
	resource.AddFile("materials/hud3/hud_warning2.vtf")
	resource.AddFile("materials/hud3/bloodbackground.png")
	resource.AddFile("materials/hud3/biohazart.vmt")
	resource.AddFile("materials/hud3/biohazart.vtf")
	resource.AddFile("materials/hud3/hud_splash.vtf")
	resource.AddFile("materials/hud3/blood_splat01.vmt")
	resource.AddFile("materials/hud3/blood_splat05.vmt")
	resource.AddFile("materials/hud3/scratch_hud_top.vtf")
	resource.AddFile("materials/hud3/scratch_hud_top.vmt")
	resource.AddFile("materials/hud3/hud3/hud_warning1.vmt")
	resource.AddFile("materials/hud3/hud3/hud_warning2.vmt")
	resource.AddFile("materials/hud3/scalablepanel_bgmidgrey_outlinegreen_glow.vmt")
	resource.AddFile("materials/hud3/scalablepanel_bgmidgrey_outlinegrey.vmt")
	resource.AddFile("materials/hud3/blood_makeup.png")
	resource.AddFile("sound/pupuletsound/robzombiehotrodremix.mp3")
	resource.AddFile("sound/pupuletsound/buttonclickrelease.wav")
	resource.AddFile("sound/pupuletsound/menu_accept.wav")
	resource.AddFile("sound/pupuletsound/Menu_Click01.wav") 
	resource.AddFile("sound/pupuletsound/unlife_pupulet.mp3")
	resource.AddFile("sound/pupuletsound/buttonclickrelease.wav") 
	resource.AddFile("sound/pupuletsound/thunder1.mp3")
	resource.AddFile("sound/pupuletsound/thunder2.mp3")
	resource.AddFile("sound/pupuletsound/thunder3.mp3")
	resource.AddFile("sound/pupuletsound/thunder4.mp3")
	resource.AddFile("models/Weapons/v_fza.mdl")
	resource.AddFile("models/Weapon/v_pza.mdl")
	resource.AddFile("models/Weapons/v_zombiearms.mdl")
	resource.AddFile("models/Weapons/v_axe.mdl")
	resource.AddFile("materials/hud3/hud_splash.vmt")
	resource.AddFile("materials/hud3/hud_bottom_panel.png")
	resource.AddFile("materials/hud3/blood_splat06.vmt")
	resource.AddFile("materials/hud3/hud_bottom_panel.vtf")
	resource.AddFile("materials/faces/avatar_engineer.vmt")
	resource.AddFile("materials/faces/avatar_medic.vmt")
	resource.AddFile("materials/faces/avatar_sharpshooter.vmt")
	resource.AddFile("materials/faces/avatar_support.vmt") 
	resource.AddFile("materials/hud3/blood_splat06.vtf")
	
	//create a gamemode data directory if it doesn't exists yet.
	if ( not file.IsDir("pupulet","DATA") ) then
		file.CreateDir("pupulet")
	end 
end  

GM.humanSpawnPoints = {};
GM.zombieSpawnPoints = {};

                                
// the net stuff 
util.AddNetworkString( "TookSupplys" )
util.AddNetworkString( "LastHuman" ) 
util.AddNetworkString( "SetHull" )
util.AddNetworkString( "PlayMusic" )
util.AddNetworkString( "SendHoard" )     
util.AddNetworkString( "setDeathTimeVariable" )      
  

function GM:PlayerInitialSpawn( pl )
		if !CAN_SPAWN_HUMAN or ZOMBIE_PLAYERS[ pl:SteamID() ] then
			pl:SetTeam( 3 ) 
			pl:Spawn()
		else
			pl:SetTeam( 1 )
		end
	pl:GetHumanClass()
	pl:GetZombieClass()
	GAMEMODE:ReadData( pl )
end 

function GM:PlayerSpawn( pl )

if ( pl:Team() == 3 && ZombieClasses[ pl:GetZombieClass() ].HullSize1 && ZombieClasses[ pl:GetZombieClass() ].HullSize2  ) then
	pl:SetHull(	ZombieClasses[ pl:GetZombieClass() ].HullSize1, ZombieClasses[ pl:GetZombieClass() ].HullSize2 ) 
	net.Start( "SetHull" )
	net.Send( pl )
else
	pl:ResetHull()
end

if( pl:Team() == 1 ) then
		pl:StripAmmo( )
		pl:StripWeapons( )
		pl:Spectate( OBS_MODE_FREEZECAM )
		pl:Flashlight( false )
		pl:AllowFlashlight( false )
		umsg.Start( "OpenClassMenuHuman", pl )
		umsg.End()
end
	if ( pl:Team() == 2 ) then
		pl:StripAmmo( )
		pl:StripWeapons( )
		pl:Spectate( OBS_MODE_FREEZECAM )
		pl:Flashlight( false )
		pl:AllowFlashlight( false )
	end
	
	
	
	if ( pl:Team() == 3 ) then
		pl:StripAmmo( )
		pl:StripWeapons( )
		pl:SetCustomCollisionCheck( true )
		self:SetUpClass( pl )
	end 
 
		if ( pl:Team() == 4 ) then
			pl:StripAmmo( )
			pl:StripWeapons( )
			pl:SetCustomCollisionCheck( true )
			self:SetUpClass( pl )
			pl:Flashlight( false )
			pl:AllowFlashlight( true )
		end
		
		//Set the model and body type
		hook.Call( "PlayerSetModel", GAMEMODE, pl )

end 

function GM:PlayerSetModel( pl )
local humanmodel = HumanClasses[ pl:GetHumanClass() ]:Hmodel() 
local zombiemodel = ZombieClasses[ pl:GetZombieClass() ].model
local zombiebodygroup = ZombieClasses[ pl:GetZombieClass() ].bodygroup

	if ( pl:Team() == 3 ) then
		pl:SetModel( zombiemodel )
			if ( pl:IsPoisonZombie() ) then
				pl:SetBodygroup( 1, 1 )
				pl:SetBodygroup( 2, 1 )
				pl:SetBodygroup( 3, 1 )
				pl:SetBodygroup( 4, 1 )
			else
				pl:SetBodygroup( zombiebodygroup, 1 )
			end	
	end
	
		if ( pl:Team() == 4 ) then 
			pl:SetModel( humanmodel )
			pl:SetupHands()
		end
	
end

 
function GM:SetUpClass( pl )
local HumanLoadout = HumanClasses[ pl:GetHumanClass() ].startingLoadOut
	if ( pl:Team() == 4 ) then
		for _, v in pairs( HumanLoadout ) do 
			pl:Give( v )
		end
		pl:SetMaxHealth( HumanClasses[ pl:GetHumanClass() ].HP )
		pl:SetHealth( HumanClasses[ pl:GetHumanClass() ].HP )
		pl:SetRunSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed )
		pl:SetWalkSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed )
		pl:SetJumpPower( HumanClasses[ pl:GetHumanClass() ].JumpPower )
	end
		
		if ( pl:Team() == 3 ) then
			pl:Give( ZombieClasses[ pl:GetZombieClass() ].Weapon )
			pl:SetMaxHealth( ZombieClasses[ pl:GetZombieClass() ].HP )
			pl:SetHealth( ZombieClasses[ pl:GetZombieClass() ].HP )
			pl:SetRunSpeed( ZombieClasses[ pl:GetZombieClass() ].RunSpeed )
			pl:SetWalkSpeed( ZombieClasses[ pl:GetZombieClass() ].RunSpeed )
			pl:SetJumpPower( ZombieClasses[ pl:GetZombieClass() ].JumpPower )
		end
			
end

function GM:PlayerDisconnected( pl )
	ZOMBIE_PLAYERS[ pl:SteamID() ] = true
	if ( ( team.NumPlayers( 1 ) + team.NumPlayers( 4 ) ) == 1 ) then 
		GAMEMODE:LastHuman()
	end
end


function GM:PlayerDeathSound( pl ) 
	return true
end




function GM:PlayerNoClip( pl )
	return true
end

function GM:ShowSpare1( pl )
	if ( pl:Team() ==  1 ) then
		umsg.Start( "OpenClassMenuHuman", pl )
		umsg.End()
	end
	if ( pl:Team() == 2 or pl:Team() == 3 ) then
		umsg.Start( "OpenZombieClasses", pl )
		umsg.End()
	end
end
   
//REDEEM!!!!!!
function GM:ShowTeam( pl )
if ( pl:Team() == 2 ) then
	if ( pl:Frags() >= 4 ) then 
		pl:UnSpectate()
		pl:SetTeam( 4 )
		pl:SetFrags( 0 )
		pl:Spawn()
		local effectdata = EffectData()
		effectdata:SetStart( pl:GetPos() ) 
		effectdata:SetOrigin( pl:GetPos() )
		effectdata:SetScale( 1 )
		util.Effect( "redeem", effectdata )	
	else
		pl:ChatPrint("You need 4 brains to redeem!")
	end
end
	if ( pl:Team() == 3 ) then
		if ( pl:Frags() >= 4 ) then
			pl:SetTeam( 4 )
			pl:SetFrags( 0 )
			pl:Spawn()
			local effectdata = EffectData()
			effectdata:SetStart( pl:GetPos() )
			effectdata:SetOrigin( pl:GetPos() )
			effectdata:SetScale( 1 )
			util.Effect( "redeem", effectdata )	
		else
			pl:ChatPrint("You need 4 brains to redeem!")
		end
	end

end

function GM:InitPostEntity( )
	GAMEMODE:createSpawnPoints()
	GAMEMODE:createZombieGasses()

end


function GM:createSpawnPoints()

local SpawnPointsZombie = {
	ents.FindByClass( "info_player_undead" ),
	ents.FindByClass( "info_player_zombie" ),
	ents.FindByClass( "info_player_rebel" ),
	ents.FindByClass( "info_player_counterterrorist" ),
	ents.FindByClass( "info_player_terrorist" ),
}

local SpawnPointsHuman = {
	ents.FindByClass( "info_player_human" ),
	ents.FindByClass( "info_player_combine" ),
	ents.FindByClass( "info_player_counterterrorist" ),
	ents.FindByClass( "info_player_terrorist" ),
}
local mapName = game.GetMap()
	for k, v in pairs( SpawnPointsZombie ) do
		if ( #v == 0 ) then continue end
		
		for p, j in pairs( v ) do
			if ( string.find( mapName, "cs_" ) && j:GetClass() == "info_player_terrorist" || string.find( mapName, "zs_" ) && j:GetClass() == "info_player_terrorist" ) then  continue end
			if ( !string.find( mapName, "cs_" ) && !string.find( mapName, "zs_" ) && j:GetClass() == "info_player_counterterrorist" || !string.find( mapName, "zs_" ) && !!string.find( mapName, "cs_" )  && j:GetClass() == "info_player_counterterrorist" ) then continue end
			table.insert( GAMEMODE.zombieSpawnPoints, j )
		end
	end
	for k, v in pairs( SpawnPointsHuman ) do
		if ( #v == 0 ) then continue end
		for p, j in pairs( v ) do
			if ( string.find( mapName, "cs_" )&& j:GetClass() == "info_player_counterterrorist" || string.find( mapName, "zs_" ) && j:GetClass() == "info_player_counterterrorist" ) then continue end
			if ( !string.find( mapName, "cs_" ) && !string.find( mapName, "zs_" ) && j:GetClass() == "info_player_terrorist" || !string.find( mapName, "zs_" ) && !!string.find( mapName, "cs_" )  && j:GetClass() == "info_player_terrorist" ) then continue end
			table.insert( GAMEMODE.humanSpawnPoints, j )
		end
	end
	
	PrintTable( GAMEMODE.humanSpawnPoints )
	PrintTable( GAMEMODE.zombieSpawnPoints )
end

function GM:createZombieGasses()
local mapName = game.GetMap()


if ( GAMEMODE.mapTable[ mapName ] && GAMEMODE.mapTable[ mapName ].specialGass ) then
	local chance = math.random( 1, #GAMEMODE.mapTable[ mapName ].specialGass )
		local specialgass = ents.Create("specialgass")
			specialgass:SetPos( GAMEMODE.mapTable[ mapName ].specialGass[ chance ] )
			specialgass:Spawn()

end
	for _, v in pairs( GAMEMODE.zombieSpawnPoints ) do
		local gasses = ents.FindByClass("zombiegasses")
		local numgasses = #gasses
			local spawnpos = v:GetPos()
			local isNear = false
		
				for _, gas in pairs(gasses) do
					if gas:GetPos():Distance(spawnpos) < 200 then
						isNear = true
						break;
					end
				end
				if !isNear then
					local ent = ents.Create("zombiegasses")
						if IsValid( ent ) then
							ent:SetPos(spawnpos)
							ent:Spawn()
						end
				end
	end
end

function GM:PlayerSelectSpawn( pl )
	if ( IsValid( pl ) && pl:Team() == 3 ) then
		local amount = #GAMEMODE.zombieSpawnPoints
		local spawnPoint = GAMEMODE.zombieSpawnPoints[ math.random( 1, amount ) ]
			if ( IsValid( spawnPoint ) && spawnPoint:IsInWorld() && spawnPoint ~= pl.lastSpawnPointZombie ) then
				pl.lastSpawnPointZombie = spawnPoint
				return spawnPoint
			end
		return pl.lastSpawnPointZombie
	end
	if ( IsValid( pl ) && pl:Team() ==  4 ) then 
		local amount = #GAMEMODE.humanSpawnPoints
		local spawnPoint = GAMEMODE.humanSpawnPoints[ math.random( 1, amount ) ]
			if ( IsValid( spawnPoint ) && spawnPoint:IsInWorld() && spawnPoint ~= pl.lastSpawnPointHuman ) then
				pl.lastSpawnPointHuman = spawnPoint
				return spawnPoint
			end
		return pl.lastSpawnPointHuman
	end
	return pl
end


function GetInfliction()
local teamZombie = team.NumPlayers( 2 ) + team.NumPlayers( 3 )
local maxPlayers = game.MaxPlayers()
local InflictionCalc = math.ceil( 100 / ( maxPlayers/teamZombie ) )
print( InflictionCalc )
	return InflictionCalc
end

function timer.SimpleEx(delay, action, ...)
	if ... == nil then
		timer.Simple(delay, action)
	else
		local a, b, c, d, e, f, g, h, i, j, k = ...
		timer.Simple(delay, function() action(a, b, c, d, e, f, g, h, i, j, k) end)
	end
end 

//LastHuman gest's handled here. we unlock all the zombie classes so he has something todo.
function GM:LastHuman()
		//only activate this once.
		if !LASTHUMAN then
			LASTHUMAN = true
		end
		GAMEMODE.musicTime = 0;
		//you can't redeem anymore.
		PLAYER_CAN_REDEEM = false

		NORMALZOMBIE_UNLOCKED = true
		HEADCRAB_UNCLOKED = true
		WRAITH_UNLOCKED = true
		FASTZOMBIE_UNLOCKED = true
		POISONCRAB_UNLOCKED = true
		POISONZOMBIE_UNLOCKED = true
		ZOMBINE_UNLOCKED = true

	//give him some fun time :v
	for k, v in pairs( team.GetPlayers( 4 ) ) do 
		if ( v:Alive() and IsValid( v ) ) then
			if ( v:GetHumanClass() == 1 ) then
				v:Give( "sp_sg550" )
			elseif( v:GetHumanClass() == 2 ) then
				v:Give( "sp_m1014" )
			elseif( v:GetHumanClass() == 3 ) then
				v:Give( "sp_m249" )
			elseif( v:GetHumanClass() == 4 ) then
				v:Give( "sp_m1014" )
			elseif ( v:GetHumanClass() == 5 ) then
				v:Give( "sp_m249" )
			else v:Give( "sp_pulserifle" )
		end
		
		end
	end
end
  

//chat messages for the server.
hook.Add( "Think", "ChatStuff", function()
local time = SERVER_HINT_TIMER 
if ( !ChatTime ) then ChatTime = 40 end 
	if ( ChatTime < CurTime() ) then 
		ChatTime =  CurTime() + time
			umsg.Start( "ChatStuff", pl )
			umsg.End()
	end
end )
//Spectators can't suicide.
function GM:CanPlayerSuicide( pl )
if pl:Team() == 1 or pl:Team() == 2 then 
	return false
else
	return true
end
end


function GM:AllowPlayerPickup( pl, ent )
	return 
end
    

//everything going on here makes YOU walk slower when you either, walk backwards OR aim with your pistol.
//Do you want this gone or make it faster or slower? 
//everything here can be altered in the "options_shared.lua"
function GM:KeyPress( pl )
if ( pl:Team() == 4 ) then
if ( pl:KeyDown( IN_ATTACK2 ) ) then

		pl:SetWalkSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed * 0.80 )
			pl:SetRunSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed * 0.80 )

end
			
	if ( pl:KeyDown( IN_BACK ) ) then

			pl:SetWalkSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed * 0.80 )
				pl:SetWalkSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed * 0.80 )
		
	end	
end
end

//When you press it, you also release it.
function GM:KeyRelease( pl, key )
if ( pl:Team() == 4 ) then
if !( pl:KeyDown( IN_BACK ) ) then
	if ( pl:KeyReleased( IN_ATTACK2 ) ) then
			pl:SetWalkSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed )
				pl:SetRunSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed )
	end
end


		
if !( pl:KeyDown( IN_ATTACK2 ) ) then
	if ( pl:KeyReleased( IN_BACK ) )  then
			pl:SetWalkSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed )
				pl:SetRunSpeed( HumanClasses[ pl:GetHumanClass() ].RunSpeed )
	end
end
end
end

concommand.Add( "drop", function ( pl, cmd, args )
	if !pl:Alive() then return end
	local Weapon = pl:GetActiveWeapon()
	
	if IsValid( Weapon ) and pl:Team() == 4 then
		Weapon.Primary.RemainingAmmo = Weapon:Clip1()
		Weapon.Primary.Magazine = pl:GetAmmoCount( Weapon:GetPrimaryAmmoType() )
		Weapon:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		pl:DropWeapon( Weapon )
	end
end )

hook.Add( "Think", "WRAITHPISS", function()
	for k, v in pairs( team.GetPlayers( 3 ) ) do 
	if v:GetZombieClass() == 3  then
		v:SetRenderMode( RENDERMODE_TRANSADD )
				if v:KeyDown( IN_ATTACK ) then
					v:SetColor( Color( 255,255,255,255 ) ) 
				else
					if math.random( 1, 16 ) == 1 then
						v:SetColor( Color( 255,255,255,255 ) ) 
					else
						v:SetColor( Color( 1,1,1,1 )  )
					end
				end
			else
				v:SetColor( Color( 255,255,255,255 ) )
			
			end
		end

end  )

 //Class&SpawnCommands.
concommand.Add( "SpawnAsHuman", function( pl )
	if ( pl:Team() == 1 and PLAYER_CAN_SPAWN_HUMANSPEC ) then
		pl:SetTeam( 4 )
		pl:UnSpectate()
		pl:Spawn()
	end
end )

concommand.Add( "SharpShooter", function( pl )
	pl:SetHumanClass( 1 )
end )

concommand.Add( "Support", function( pl )
	pl:SetHumanClass( 2 )
end )

concommand.Add( "Commando", function( pl )
	pl:SetHumanClass( 3 )
end )

concommand.Add( "Berserker", function( pl )
	pl:SetHumanClass( 4 )
end )

concommand.Add( "Medic", function( pl )
	pl:SetHumanClass( 5 )
end )

concommand.Add( "Engineer", function( pl )
	pl:SetHumanClass( 6 )
end )


concommand.Add( "NormalZombie", function( pl )
	if ( NORMALZOMBIE_UNLOCKED ) then
		if ( pl:Team() == 2 ) then
			pl:SetZombieClass( 1 )
			pl:SetTeam( 3 )
			pl:Spawn()
		else 
			pl:Kill()
			pl:SetZombieClass( 1 )
		end
	end
end )

concommand.Add( "HeadCrab", function( pl )
	if ( HEADCRAB_UNCLOKED ) then
		if ( pl:Team() == 2 ) then
			pl:SetZombieClass( 2 )
			pl:SetTeam( 3 )
			pl:Spawn()	
			
		else 
			pl:Kill()
			pl:SetZombieClass( 2 )	
		end
	end
end )

concommand.Add( "Stalker", function( pl )
	if ( WRAITH_UNLOCKED ) then
		if ( pl:Team() == 2 ) then
			pl:SetZombieClass( 3 )
			pl:SetTeam( 3 )	
			pl:Spawn()	
		else 
			pl:Kill()
			pl:SetZombieClass( 3 )	
		end
	end
end )

concommand.Add( "FastZombie", function( pl )
	if( FASTZOMBIE_UNLOCKED ) then
		if ( pl:Team() == 2 ) then
			pl:SetZombieClass( 4 )
			pl:SetTeam( 3 )	
			pl:Spawn()	
		else 
			pl:Kill()
			pl:SetZombieClass( 4 )
		end
	end
end )

concommand.Add( "PoisonCrab", function( pl )
	if( POISONCRAB_UNLOCKED ) then
		if ( pl:Team() == 2 ) then
			pl:SetZombieClass( 5 )
			pl:SetTeam( 3 )	
			pl:Spawn()	
		else 
			pl:Kill()
			pl:SetZombieClass( 5 )
		end
	end
end )

concommand.Add( "PoisonZombie", function( pl )
	if( POISONZOMBIE_UNLOCKED ) then
		if ( pl:Team() == 2 ) then
			pl:SetZombieClass( 6 )
			pl:SetTeam( 3 )	
			pl:Spawn()	
		else 
			pl:Kill()
			pl:SetZombieClass( 6 )
		end
	end
end )

concommand.Add( "Zombine", function( pl )
	if( ZOMBINE_UNLOCKED ) then
		if ( pl:Team() == 2 ) then
			pl:SetZombieClass( 7 )
			pl:SetTeam( 3 )	
			pl:Spawn()	 
		else 
			pl:Kill()
			pl:SetZombieClass( 7 )
		end
	end
end )

concommand.Add( "spawbot", function( pl )
	for i = 0, game.MaxPlayers() do 
		RunConsoleCommand( 'bot' )
	end
end ) 

concommand.Add( "setZombieClass", function( pl, cmd, args, str )
	for k, v in pairs( player.GetAll() ) do 
		if v:Team() == 2 || v:Team() == 3 then
			v:Kill()
			v:SetZombieClass( tonumber( args[ 1 ] ) )
		end
	end
end ) 

