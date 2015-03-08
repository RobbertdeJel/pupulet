local META = FindMetaTable( "Player" )
if (!META) then return end


function META:HasThisWeaponSkin(  _Gun, _Rarety, _Type  )
	self.DataTable =  util.JSONToTable( file.Read ( "pupulet/player_"..string.Replace( string.sub( self:SteamID(), 1 ), ":", "-" )..".txt" ) )
		if self.DataTable[ "gunskins" ][ _Gun ][ _Rarety ]  then
			if self.DataTable[ "gunskins" ][ _Gun ][ _Rarety ][ _Type ] then
				return true
			else
				return false
			end
		
		end
			return false			
end

function META:setPlayerSpeed( speed )
	self:SetWalkSpeed( speed )
	self:SetRunSpeed( speed )
end


function META:resetPlayerSpeed( classTable )
local speed = 0
	if ( self:Team() == 4 || #self:GetWeapons() > 0 ) then // are we human AND do we even have a god damn weapon..
		for k, v in pairs( self:GetWeapons() ) do
			if ( !IsValid( v ) || !v.weight ) then continue; end //not valid or no value? skip it.
				speed = speed + v.weight // add the value's.
		end
		self:SetWalkSpeed( self:GetRunSpeed() - speed )
		self:SetRunSpeed( self:GetRunSpeed() - speed )
	else // so there were no weapons..
		if ( classTable && classTable.RunSpeed ) then // did we even send the table..
			self:SetWalkSpeed( classTable.RunSpeed )
			self:SetRunSpeed( classTable.RunSpeed )
		else
			self:SetWalkSpeed( 180 )
			self:SetRunSpeed( 180 )
		end
	end
	if ( self:Team() == 3 && classTable ) then
		self:SetWalkSpeed( classTable.RunSpeed )
		self:SetRunSpeed( classTable.RunSpeed )
	end
end

function META:GiveAmmos()
	if ( IsValid ( self:GetActiveWeapon() ) ) then 
	local wep = self:GetActiveWeapon()
		if ( IsValid( self ) and IsValid( wep ) ) then
			if ( wep.Primary.Ammo == "slam" or wep.Primary.Ammo == "grenade" ) then
				AmmoAmount = 1
			else
				AmmoAmount = wep.Primary.ClipSize * 2
				
			end
			self:GiveAmmo( AmmoAmount, wep:GetPrimaryAmmoType() )
		end
	end
end

function META:IsAFemale()
	local model = self:GetModel()
	if string.find(model, "female") or string.find(model, "alyx") or string.find(model, "mossman") then
		return true
	else
		return false
	end
end	

function META:MeleeViewPunch(damage)
	local maxpunch = (damage + 25) * 0.5
	local minpunch = -maxpunch
	self:ViewPunch(Angle(math.Rand(minpunch, maxpunch), math.Rand(minpunch, maxpunch), math.Rand(minpunch, maxpunch)))
end

function META:GetMeleeFilter()
	return team.GetPlayers( self:Team() )
end

function META:GetLegDamage()
	return math.max(0, self:GetDTFloat(2) - CurTime())
end


function META:GetPoisonDamage()
	return self.PoisonRecovery and self.PoisonRecovery:IsValid() and self.PoisonRecovery:GetDamage() or 0
end 

function META:GetHolding()
	local status = self.status_human_holding
	if status and status:IsValid() then
		local obj = status:GetObject()
		if obj:IsValid() then return obj end
	end

	return NULL
end

function META:IsHolding()
	return self:GetHolding():IsValid()
end
META.IsCarrying = META.IsHolding


function META:SaveSkinTypes( _SkinRarety, _SkinNumber )
		self.GunSkinSaveTable = {}
		
		table.insert( self.GunSkinSaveTable, _SkinRarety, _SkinNumber )    
end 

function META:GetSkinTypes()
	if self.GunSkinSaveTable and #self.GunSkinSaveTable > 0 then
		return self.GunSkinSaveTable
	end
end


function META:SetZombieClass( classnumber )
	self:SetDTInt( 2, classnumber )
end

function META:SetHumanClass( classnumber )
	self:SetDTInt( 1, classnumber )
end


function META:IsHuman()
	return self:Team() == 4
end

function META:IsZombie()
	return self:Team() == 3
end

function META:IsPoisonZombie()
	return self:GetZombieClass() == 6
end

function META:TookSuppliesTime( Time )
	self:SetDTInt( 4, CurTime() + Time )
end