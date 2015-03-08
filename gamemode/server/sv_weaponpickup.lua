include( "sv_classes.lua" ) 


local function canPickUp( pl, wep )
local hasWeapons = pl:GetWeapons()
	for k, v in pairs( hasWeapons ) do
		if ( WeaponInfo[ v:GetClass() ].weaponSlot == WeaponInfo[ wep:GetClass() ].weaponSlot ) then
			return false
		end
	end
	return true
end

function GM:PlayerCanPickupWeapon( pl, wep )
	if (  wep.GetClass && WeaponInfo[ wep:GetClass() ] && pl:Team() == 4 ) then
		if ( IsValid( pl ) && IsValid( wep ) && canPickUp( pl, wep ) ) then
			return true
		end
	end
	if ( pl:Team() == 3 and wep:GetClass() == ZombieClasses[ pl:GetZombieClass() ].Weapon and !pl:HasWeapon( wep:GetClass() )  ) then 
		return true
	end
return false
end 