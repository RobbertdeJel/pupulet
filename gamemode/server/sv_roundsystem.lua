
NORMALZOMBIE_UNLOCKED = false;
HEADCRAB_UNCLOKED = false;
WRAITH_UNLOCKED = false;
FASTZOMBIE_UNLOCKED = false;
POISONCRAB_UNLOCKED = false;
POISONZOMBIE_UNLOCKED = false;
ZOMBINE_UNLOCKED = false;
  
GM.mapTable = { 
	["zs_filth_v3"] = { 
	crateSpawnPlaces = {  
	[ 1 ] = Vector( -1500.654297, 547.738892, -383.968750 ),[ 2 ] = Vector( -1170.435669, 856.641052, -255.968750 ),[ 3 ] = Vector( -166.204437, 685.799377, -255.968750 ),
	[ 4 ] = Vector( 1242.503540, 1050.786255, -383.968750 ), [ 4 ] = Vector( 902.207397, 176.568405, -383.968750 ), [ 4 ] = Vector( 162.629715, 131.183533, -383.968750 ) 
	}, 
	specialGass = { [ 1 ] = Vector( -687.737549, -282.104858, -191.968750 ) },
	}
}

GM.gameTime, GM.gameState = 0, 0;
GM.crateSpawned, GM.canPlayMusic, GM.musicTime, GM.ammoRegenTime = false, false, 0, 0; 
GM.canSendMessage = false, false;


local testTable = {
[ 0 ] = { func = function()//preparation time.
		GAMEMODE.gameTime = CurTime() + 90;
		GAMEMODE.gameState = 1;
		GAMEMODE:setGameTime( 1, 90 );
		CAN_SPAWN_HUMAN = true;
 end },
[ 1 ] = { func = function() // Let the games begin!
		GAMEMODE.gameTime = CurTime() + 210;
		GAMEMODE.gameState = 2;
		GAMEMODE:setGameTime( 1, 1110 );
		GAMEMODE:spawnSpectators();
		GAMEMODE.canPlayMusic = true;
		CAN_SPAWN_HUMAN = false;
		NORMALZOMBIE_UNLOCKED = true;
		HEADCRAB_UNCLOKED = true;
		GAMEMODE:GamStartSlay();
		SendGameMessage( 5, "here they come! BRAAAAINSSSSss...", 2, Vector( 255, 255, 255 ) );
		GAMEMODE:SpawnSupplyCrate();

 end },
[ 2 ] = { func = function() // Second wave.
		GAMEMODE.gameTime = CurTime() + 300;
		GAMEMODE.gameState = 3;
		SendGameMessage( 5, "Supplies Moved! Go and find them", 2, Vector( 255, 255, 255 ) );
		SendGameMessage( 5, "New zombie classes unlocked!", 1, Vector( 255, 255, 255 ) );
		WRAITH_UNLOCKED = true;
		FASTZOMBIE_UNLOCKED = true;
		GAMEMODE:SpawnSupplyCrate();
 end },
[ 3 ] = { func = function() //	Third wave.
		GAMEMODE.gameTime = CurTime() + 300;
		GAMEMODE.gameState = 4;
		SendGameMessage( 5, "Supplies Moved! Go and find them", 1, Vector( 255, 255, 255 ) );
		SendGameMessage( 5, "New zombie classes unlocked!", 1, Vector( 255, 255, 255 ) );
		POISONCRAB_UNLOCKED = true;	
		POISONZOMBIE_UNLOCKED = true;
		GAMEMODE:SpawnSupplyCrate( pl );		
 end },
[ 4 ] = { func = function() // Fourth wave.
		GAMEMODE.gameTime = CurTime() + 300;
		GAMEMODE.gameState = 5;
		SendGameMessage( 5, "Supplies Moved! Go and find them", 1, Vector( 255, 255, 255 ) );
		SendGameMessage( 5, "Everything is unlocked! Good luck..", 1, Vector( 255, 255, 255 ) );
		ZOMBINE_UNLOCKED = true
		GAMEMODE:SpawnSupplyCrate();

 end },
[ 5 ] = { func = function() //They won!
		GAMEMODE.gameTime = CurTime() + 30;
		ENDING_ACTIVE = true;
 end },
[ 6 ] = { func = function() //They lost..
		GAMEMODE.gameTime = CurTime() + 30;
		ENDING_ACTIVE = true;
 end },
}

hook.Add( "Think", "RoundHandeler", function( pl )
	if ( testTable[ GAMEMODE.gameState ].func && GAMEMODE.gameTime < CurTime() ) then
		testTable[ GAMEMODE.gameState ].func()
	end 
end )

hook.Add( "Think", "roundMusic", function()
	if ( GAMEMODE.canPlayMusic && GAMEMODE.musicTime < CurTime() ) then
		local songID = math.random( 1, #SongTable );
		local uSong, uTime = "pupuletsound/unlife_pupulet.mp3", ( CurTime() + 630 ); 
		local lSong, lTime = "pupuletsound/robzombiehotrodremix.mp3",( CurTime() +  277 );

		if ( !ENDING_ACTIVE && !LASTHUMAN && !HALF_LIFE ) then
			GAMEMODE.musicTime = CurTime() + SongTable[songID].time 
			GAMEMODE:playMusic( true, SongTable[songID].command );
		elseif ( HALF_LIFE && !LASTHUMAN && !ENDING_ACTIVE ) then
			GAMEMODE.musicTime = CurTime() + uTime;
			GAMEMODE:playMusic( true, uSong );
		elseif ( LASTHUMAN && !ENDING_ACTIVE ) then
				GAMEMODE.musicTime = CurTime() + lTime;
				GAMEMODE:playMusic( true, lSong );
		end
	end

end)

hook.Add( "Think", "AmmoRegen", function()
	if ( GAMEMODE.ammoRegenTime < CurTime() ) then
		GAMEMODE.ammoRegenTime = CurTime() + 90;
		GAMEMODE:ammoRegen();
	end
end ) 

function GM:spawnSpectators()
local teamPlayers = team.GetPlayers( 1 );
	for k, v in pairs( teamPlayers ) do
		v:SetTeam( 4 );
		v:UnSpectate();
		v:Spawn();
	end
end

function GM:ammoRegen()
local teamPlayers = team.GetPlayers( 4 );
	for k, v in pairs( teamPlayers ) do
		if IsValid( v ) && v:Alive() then
			v:GiveAmmos();
			GAMEMODE:setGameTime( 2, 90 );
		end
	end

end

function GM:playMusic( bool, song )
	net.Start( "PlayMusic" )  
		net.WriteBit( bool )
		net.WriteString( song )
	net.Broadcast()
end


// we use these for multiple thing
// thanks for explaining necro :v
function GM:setGameTime( id , time )   
	local ent = game.GetWorld()    
	ent:SetDTFloat( id, CurTime() + time ) 
end

function SendGameMessage( time, text, sType, color )             
	net.Start( "SendHoard" )   
		net.WriteFloat( time )  
		net.WriteString( text )    
		net.WriteFloat( sType )
		net.WriteVector( color )
	net.Broadcast()                          
end

//DEATH.
function GM:GamStartSlay()
local HumanAmount = team.NumPlayers( 1 ) + team.NumPlayers( 4 )
local Players = player.GetAll()
local amount = math.floor( HumanAmount * 0.20 )
if #Players < 1 then return end

		for i = 1, amount do
		local random = math.random( 1, #Players )  
		local Chosen = Players[ random ]
		table.remove( Players ,random )
		if ( IsValid( Chosen ) and Chosen:Team() == 1 or Chosen:Team()== 4 )  then
			Chosen:KillSilent()
			Chosen:SetTeam( 3 )
			Chosen:UnSpectate()
			Chosen:Spawn()
		end
		end
end     

/*
function GiveReward( pl )
		
	
	local ChanceOne = math.random( 1, 20 )
	if math.random( 1, 20 ) >= 13 then
		RARETY_CHANCE = 1
	elseif math.random( 1, 20 ) >= 15 then
		RARETY_CHANCE = 2
	elseif math.random( 1, 20 ) >= 18 then
		RARETY_CHANCE = 3
	elseif math.random( 1, 20 ) >= 19 then
		RARETY_CHANCE = 4
	elseif math.random( 1, 20 ) == 20 then
		RARETY_CHANCE = 5
	end
	if RARETY_CHANCE then
		pl:ChatPrint( RARETY_CHANCE )
	else
		RARETY_CHANCE = 1
	end
	local ChanceTwo = math.random( 1, #WeaponSkins[ RARETY_CHANCE ] )
	
	pl:SaveSkinTypes( RARETY_CHANCE, ChanceTwo )
	PrintTable( pl:GetSkinTypes() )  
	GAMEMODE:ReWriteDatatables( pl, "Weapon",	"sp_glock", pl:GetSkinTypes() )
	
end    
*/
 
 
function GM:SpawnSupplyCrate( pl )  
if !GAMEMODE.mapTable[ game.GetMap() ] && !GAMEMODE.mapTable[ game.GetMap() ].crateSpawnPlaces then return end
local Spot = math.random( 1, #GAMEMODE.mapTable[ game.GetMap() ].crateSpawnPlaces );
local crate = ents.FindByClass( "item_supplycrate" );
	
	if ( !GAMEMODE.crateSpawned ) then
		GAMEMODE.crateSpawned = true;
		GAMEMODE:playMusic( false, "pupuletsound/thunder"..math.random( 1, 4 )..".mp3" )
		SendGameMessage( 5, "Supplies dropped! Go and find them.", 2, Vector( 255, 255, 255 ) );
		local Supplies = ents.Create( "item_supplycrate" );
			Supplies:SetPos( GAMEMODE.mapTable[ game.GetMap() ].crateSpawnPlaces[ Spot ]  ) ;
			Supplies:Spawn() ;
	else
		GAMEMODE:playMusic( false, "pupuletsound/thunder"..math.random( 1, 4 )..".mp3" )
		SendGameMessage( 5, "Supplies Moved! Go and find them", 2, Vector( 255, 255, 255 ) );
		for k, v in pairs( crate ) do
			v:Remove()
			timer.Simple( 1, function()
				local Supplies = ents.Create( "item_supplycrate" );
					Supplies:SetPos( GAMEMODE.mapTable[ game.GetMap() ].crateSpawnPlaces[ Spot ]  ) ;
					Supplies:Spawn() ;
			end )
		end
	end 
end