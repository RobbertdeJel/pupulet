
include( "sv_weaponskins.lua" )


function GM:GetBlankStats( pl )
	local data = {
	[ "name" ] = pl:Nick(),
	[ "id" ] = pl:SteamID(),
	[ "XP" ] = 0,
	[ "gunskins" ] = {
	[ "sp_mp5" ] = {},  
	[ "sp_p90" ] = {},
	[ "sp_galil" ] = {},
	[ "sp_aug" ] = {},
	[ "sp_awp" ] = {},
	[ "sp_deagle" ] = {},
	[ "sp_elites" ] = {},
	[ "sp_famas" ] = {},
	[ "sp_fiveseven" ] = {},
	[ "sp_glock" ] = {},
	[ "sp_m3" ] = {},
	[ "sp_m4a1" ] = {},
	[ "sp_m1014" ] = {},
	[ "sp_p228" ] = {},
	[ "sp_pulserifle" ] = {},
	[ "sp_pulsesmg" ] = {},
	[ "sp_scout" ] = {},
	[ "sp_sg550" ] = {},
	[ "sp_shotgun" ] = {},
	[ "sp_smg" ] = {},
	[ "sp_ump" ] = {},
	["sp_usp" ] = {},
	[ "sp_magnum" ] = {},
	[ "sp_hl2_pistol" ] = {},
	[ "sp_m249" ] = {},
	[ "sp_ak" ] = {},
	[ "sp_tmp" ] = {},
	[ "sp_mine" ] = {},
	[ "sp_knife" ] = {},
	[ "sp_axe" ] = {},
	[ "sp_pot" ] = {},
	[ "sp_crowbar" ] = {},
	[ "sp_mac10" ] = {},
	},
	}
	
	for k, v in pairs( data[ "gunskins" ] ) do
		for i = 0, 5 do 
			if i > 0 then
				table.insert( data[ "gunskins" ][ k ], i, {} )//prep the table for later..
			end
		end
		for a = 0, 5  do
			if a > 0 then
				for i = 0, #WeaponSkins[ a ] do 
					if i > 0 then
							table.insert( data[ "gunskins" ][ k ][ a ], i , false )
						end
					end
				end
			end
		end
		
	
	return util.TableToJSON( data )
end

function GM:WriteBlank( pl )

	local path = "pupulet/player_"..string.Replace( string.sub(pl:SteamID(), 1), ":", "-" )..".txt"
	local data = self:GetBlankStats(pl)

		file.Write( path, data )

end


function GM:ReadData( pl )
	local path = "pupulet/player_"..string.Replace( string.sub(pl:SteamID(), 1), ":", "-" )..".txt"
	if not file.Exists( path ,"DATA") then
		GAMEMODE:WriteBlank( pl )
		for _, v in pairs( player.GetAll() ) do 
			if IsValid( v ) then
				v:ChatPrint( "Welcome "..pl:Nick().."as he has joined for the first time!" )
			end
		end
	end
		
end

/*----------------------------------------------------------------------------------------------------
//Copyright (C) 2014 by Robbert de Jel ( robbertdejel@hotmail.com ) - all rights reserved.
*/-----------------------------------------------------------------------------------------------------
function GM:ReWriteDatatables( pl, _String,	_Weapon, _InfoToSave )
	local path = "pupulet/player_"..string.Replace( string.sub(pl:SteamID(), 1), ":", "-" )..".txt"
	pl.DataTable =  util.JSONToTable( file.Read ( path ) )
	
	if ( _String == "Weapon" ) then
		if ( _Weapon and _InfoToSave ) then
			for k, v in pairs( _InfoToSave ) do 
				if ( pl.DataTable["gunskins"][ _Weapon ][ k ] ) then
					if ( !pl.DataTable[ "gunskins" ][ _Weapon ][ k ][ v ] ) then 
							pl.DataTable["gunskins"][ _Weapon ][ k ][ v ] = true
							file.Write( path, util.TableToJSON( pl.DataTable ) )
							pl:ChatPrint( "You have received a new weapon! Check your inventory for more information. ( [ F3 ] As a human! )" )
					end
				end
			end
		end
	end
end
