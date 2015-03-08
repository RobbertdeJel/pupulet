include( "sv_classes.lua" ) 
include( 'obj_player.exstended.lua' )

//what weapon are they gonne get? this goes in %. example: 4 = 40%
local CrateRewardTable = {
	[ 4 ] = { [ 1 ] = "weapon_zs_elites", [ 2 ] = "weapon_zs_glock", [ 3 ] = "weapon_zs_plank", [ 4 ] = "weapon_zs_fiveseven" },
	[ 5 ] = { [ 1 ] = "weapon_zs_glock", [ 2 ] = "weapon_zs_deagle", [ 3 ] = "weapon_zs_plank", [ 4 ] = "weapon_zs_fiveseven" },
	[ 6 ] = { [ 1 ] = "weapon_zs_ump", [ 2 ] = "weapon_zs_tmp", [ 3 ] = "weapon_zs_mac10", [ 4 ] = "weapon_zs_pot", [ 5 ] = "weapon_zs_fryingpan" },
	[ 7 ] = { [ 1 ] = "weapon_zs_p90", [ 2 ] = "weapon_zs_ak47", [ 3 ] = "weapon_zs_galil" },
	[ 8 ] = { [ 1 ] = "weapon_zs_crowbar", [ 2 ] = "weapon_zs_axe", [ 3 ] = "weapon_zs_ak47", [ 4 ] = "weapon_zs_m4a1" },
	[ 9 ] = { [ 1 ] = "weapon_zs_m249", [ 2 ] = "weapon_zs_m1014", [ 3 ] = "weapon_zs_pulserifle" },
	[ 10 ] = { [ 1 ] = "weapon_zs_m249", [ 2 ] = "weapon_zs_m1014", [ 3 ] = "weapon_zs_pulserifle" },
}	

local function rewardNewWeapon( pl, ent )
local WeaponTierCalc = math.floor( GetInfliction() / 10 )
local curWeapons = pl:GetWeapons()
	if ( IsValid( pl ) &&  CrateRewardTable[ WeaponTierCalc ] ) then
	local chance = math.random( 1, #CrateRewardTable[ WeaponTierCalc ] )
	local newWep =  CrateRewardTable[ WeaponTierCalc ][ chance ]
		if ( #curWeapons == 0  ) then pl:Give( newWep ) end
			for k, v in pairs( curWeapons ) do
				if( newWep ~= v:GetClass() &&  WeaponInfo[ v:GetClass() ].weaponSlot == WeaponInfo[ newWep ].weaponSlot && WeaponInfo[ v:GetClass() ].dps <= WeaponInfo[ newWep ].dps ) then
					v:Remove()
					timer.Simple( 0.5, function()
						pl:Give( newWep )
						pl:SelectWeapon( newWep )
					end )
				else
					pl:Give( newWep )
					pl:SelectWeapon( newWep )
				end
			end
	end	
end

local function giveAmmo( pl, ent )
local Weapons = pl:GetWeapons()
	for _, v in pairs( Weapons )  do
		if ( v.Primary.Ammo == "slam" or v.Primary.Ammo == "grenade" ) then
			amount = 3
		else
			amount = v.Primary.ClipSize * 4
		end
			pl:GiveAmmo( amount, v:GetPrimaryAmmoType() )
	end
end

local function giveHealth( pl, ent )
	local HealAmountamount = math.Clamp( 25 + GetInfliction(), 25, 40 )
	local maxHealth = pl:GetMaxHealth()
	
		if( pl:Health() +  HealAmountamount >= maxHealth ) then 
			pl:SetHealth( maxHealth ) 		
		else
			pl:SetHealth( pl:Health() + HealAmountamount )
		end
end

function GM:PlayerUse( pl, entity )

	if ( entity.IsCrate && pl:GetSuppliesTime() <= CurTime() ) then
		test = CurTime() + 2
		local HealAmountamount = math.Clamp( 25 + GetInfliction(), 25, 40 )
		pl:TookSuppliesTime( 230 )
		rewardNewWeapon( pl, ent )
		giveAmmo( pl, ent )
		giveHealth( pl, ent )
		
	end
	return true
end