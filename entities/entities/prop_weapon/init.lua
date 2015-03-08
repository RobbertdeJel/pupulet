AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
--AddCSLuaFile("cl_animations.lua")

include("shared.lua")



function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return end
	if !activator:Alive() then return end
	if activator:Team() ~= 4 then return end
	
	
	if !activator:HasWeapon( self.WeaponType ) then
		--print( "hi" )
		local wep = activator:GetWeapon( self.WeaponType )
		--print( "hi" )
		--print( "hi" )
		--print( "hi" )
		print( self.Magazine ) 
		activator:Give( self.WeaponType )
		wep.RemainingAmmo = 0
		--wep:SetClip1( 0 )
		--wep:SetAmmo( 0 )
	end
		
end

