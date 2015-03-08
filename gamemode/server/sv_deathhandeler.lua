include( 'obj_player.exstended.lua' )
include( 'sv_classes.lua' )


// storing empty tables 
ZOMBIE_PLAYERS = {}

local deathTimeTable = {
	[ 1 ] = { waitTime = 0, nextSpawn = 8 },
	[ 2 ] = { waitTime = 0, nextSpawn = 9 },
	[ 3 ] = { waitTime = 0, nextSpawn = 12 },
	[ 4 ] = { waitTime = 0, nextSpawn = 12 },
	[ 5 ] = { waitTime = 0, nextSpawn = 15 },
	[ 6 ] = { waitTime = 0, nextSpawn = 18 },
	[ 7 ] = { waitTime = 0, nextSpawn = 22 },
}

local RewardsTable = { --SharpShooter
[ 1 ] = {
		[ 5 ] = { [ 1 ] = "weapon_zs_deagle", [ 2 ] = "weapon_zs_elites", [ 3 ] = "weapon_zs_magnum", [ 4 ] = "weapon_zs_fiveseven", [ 5 ] = "weapon_zs_glock" },--5
		[ 15 ] = { [ 1 ] = "weapon_zs_p90", [ 2 ] = "weapon_zs_mp5" },--15
		[ 25 ] = { [ 1 ] = "weapon_zs_scout", [ 2 ] = "weapon_zs_galil" },--25
		[ 35 ] = { [ 1 ] = "weapon_zs_sg550"},--35
		[ 75 ] = { [ 1 ] = "weapon_zs_awp" },--75
	},
[ 2 ] = { --Support
		[ 5 ] = { [ 1 ] = "weapon_zs_deagle", [ 2 ] = "weapon_zs_elites", [ 3 ] = "weapon_zs_magnum", [ 4 ] = "weapon_zs_fiveseven", [ 5 ] = "weapon_zs_glock" },
		[ 15 ] = { [ 1 ] = "weapon_zs_tmp", [ 2 ] = "weapon_zs_ump", [ 3 ] = "weapon_zs_p90" },
		[ 25 ] = { [ 1 ] = "weapon_zs_smg", [ 2 ] = "weapon_zs_mp5" },
		[ 35 ] = { [ 1 ] = "weapon_zs_m249", [ 2 ] = "weapon_zs_m3" },
		[ 75 ] = { [ 1 ] = "weapon_zs_shotgun", [ 2 ] = "weapon_zs_m1014" },
	},
[ 3 ] = { -- Commando
		[ 5 ] = { [ 1 ] = "weapon_zs_deagle", [ 2 ] = "weapon_zs_elites", [ 3 ] = "weapon_zs_magnum", [ 4 ] = "weapon_zs_fiveseven", [ 5 ] = "weapon_zs_glock" },--5
		[ 15 ] = { [ 1 ] = "weapon_zs_p90", [ 2 ] = "weapon_zs_mp5" },--15
		[ 25 ] = { [ 1 ] = "weapon_zs_aug", [ 2 ] = "weapon_zs_galil", [ 3 ] = "weapon_zs_ak", [ 4 ] = "weapon_zs_m4a1"  },--25
		[ 35 ] = { [ 1 ] = "weapon_zs_famas"},--35
		[ 75 ] = { [ 1 ] = "weapon_zs_m249" },--75
	},
[ 4 ] = { --Berserker
		[ 5 ] = { [ 1 ] = "weapon_zs_fiveseven" },--5
		[ 15 ] = { [ 1 ] = "weapon_zs_axe" },--15
		[ 25 ] = { [ 1 ] = "weapon_zs_glock3", [ 2 ] = "weapon_zs_magnum" },--25
		[ 35 ] = { [ 1 ] = "weapon_zs_katana"},--35
		[ 75 ] = {[ 1 ] =  "weapon_zs_shotgun", [ 2 ] = "weapon_zs_m1014" },--75
	},
[ 5 ] = { --Medic
		[ 5 ] = { [ 1 ] = "weapon_zs_deagle", [ 2 ] = "weapon_zs_elites", [ 3 ] = "weapon_zs_fiveseven" },--5
		[ 15 ] = { [ 1 ] = "weapon_zs_glock", [ 2 ] = "weapon_zs_magnum" },--15
		[ 25 ] = { [ 1 ] = "weapon_zs_ump", [ 2 ] = "weapon_zs_tmp" },--25
		[ 35 ] = { [ 1 ] = "weapon_zs_sg550" },--35
		[ 75 ] = { [ 1 ] = "weapon_zs_shotgun", [ 2 ] = "weapon_zs_m1014" },--75
	},
[ 6 ] = { --Engineer
		[ 5 ] = { [ 1 ] = "weapon_zs_deagle", [ 2 ] = "weapon_zs_elites", [ 3 ] = "weapon_zs_magnum", [ 4 ] = "weapon_zs_fiveseven", [ 5 ] = "weapon_zs_glock" },--5
		[ 15 ] = { [ 1 ] = "weapon_zs_pulsesmg" },--15
		[ 25 ] = { [ 1 ] = "weapon_zs_pulserifle" },--25
		[ 35 ] = { [ 1 ] = "weapon_zs_m249"},--35
		[ 75 ] = { [ 1 ] = "weapon_zs_shotgun", "weapon_zs_m1014" },--75
	},
}

function GM:setDeathTime( time, target )
	net.Start( "setDeathTimeVariable" )
		net.WriteFloat( time )
	net.Send( target )
end


//if he's human he drops his active weapon.
function GM:DoPlayerDeath( pl )
	if ( pl:Team() == 4 ) then
		pl:ShouldDropWeapon( true )
	else 
		pl:ShouldDropWeapon( false )
	end
end	

local function rewardWeapon( killer )
local chance = math.random( 1, #RewardsTable[ killer:GetHumanClass() ][ killer:Frags() ] )
local newWep = RewardsTable[ killer:GetHumanClass() ][ killer:Frags() ][ chance ]
local curWeapons = killer:GetWeapons()

	if ( #curWeapons == 0 ) then killer:Give( newWep ) end 
	for k, v in pairs( curWeapons ) do
		if( newWep ~= v:GetClass() &&  WeaponInfo[ v:GetClass() ].weaponSlot == WeaponInfo[ newWep ].weaponSlot && WeaponInfo[ v:GetClass() ].dps <= WeaponInfo[ newWep ].dps ) then
			v:Remove()
			timer.Simple( 0.5, function()
				killer:Give( newWep )
				killer:SelectWeapon( newWep )
			end )
		else
			killer:Give( newWep )
			killer:SelectWeapon( newWep )
		end
	end
end

//Gamemode logics get handled here. 
function GM:PlayerDeath( pl, weapon, killer )
	local teams = team.NumPlayers( 4 ) + team.NumPlayers( 1 )
//if his team is 4 ( Team human ) then reset his frags ( kills ) to 0 and set his team to 2. ( zombie spectator )
// we also give him a respawn delay, so he has to wait a little before he can respawn.
	if ( pl:Team() == 4 ) then
		if ( HumanClasses[ pl:GetHumanClass() ].deathFunc ) then
			HumanClasses[ pl:GetHumanClass() ].deathFunc( pl )
		end
		ZOMBIE_PLAYERS[ pl:SteamID() ] = true
		pl:SetTeam( 2 )
		pl:SetFrags( 0 )
		pl.nextspawn = deathTimeTable[ pl:GetZombieClass() ].waitTime
		GAMEMODE:setDeathTime( pl.nextspawn, pl )
		pl.CanRespawn = false
	end
	if ( pl:Team() == 3 ) then
		if ( ZombieClasses[ pl:GetZombieClass() ].deathFunc ) then
			ZombieClasses[ pl:GetZombieClass() ].deathFunc( pl, weapon, killer )
		end
		pl:SetTeam( 2 )
		pl.nextspawn = deathTimeTable[ pl:GetZombieClass() ].waitTime
		GAMEMODE:setDeathTime( pl.nextspawn, pl )
		pl.CanRespawn = false
	end

		if pl ~= killer && killer:IsPlayer() then
			killer:AddFrags( 1 )
		end
	
	
		if ( killer:IsPlayer() && killer:Team() == 4 && RewardsTable[ killer:GetHumanClass() ][ killer:Frags() ] ) then
			rewardWeapon( killer )
		end
		
		
		if ( !HALF_LIFE && GetInfliction() > 48 && !ENDING_ACTIVE && !LASTHUMAN ) then
			HALF_LIFE = true;
			GAMEMODE.musicTime = 0;
		end
		
		
		if ( team.NumPlayers( 4 ) == 0 && !ENDING_ACTIVE ) then
			GAMEMODE.gameState = 6;
			GAMEMODE.gameTime = 0;
		end
	
	
	if ( teams == 1 ) then 
		GAMEMODE:LastHuman()
	end
	print( pl.nextspawn, CurTime(),deathTimeTable[ pl:GetZombieClass() ].waitTime  )
end 

//Respawn delay get's handled here, after the timer eaches 0 we set his respawn value to true so he can respawn.
function GM:PlayerDeathThink( pl )
	if ( !pl.nextspawn ) then pl.nextspawn = CurTime() + 3 end
		 if ( CurTime() >= pl.nextspawn ) then
			if ( pl:Team() == 2 ) then
				pl.CanRespawn = true
			end
			deathTimeTable[ pl:GetZombieClass() ].waitTime = CurTime() + deathTimeTable[ pl:GetZombieClass() ].nextSpawn
		end
	
		if ( pl:Team() == 2 && pl.CanRespawn && pl:KeyDown( IN_ATTACK ) ) then
			pl:SetTeam( 3 )
			pl:Spawn()
		end
end
