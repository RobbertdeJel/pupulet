ENT.Type = "anim"

ENT.RemainingAmmo = 0
ENT.Magazine = 0


function ENT:Initialize()
print( "hi" ) 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	--self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self.WeaponType = self.WeaponType or nil
	self:SetModel( self:GetModel() )
	--self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMaterial( "models/de_piranesi/pi_apc" )
		phys:EnableMotion(true)
		phys:Wake()
	end
end

function ENT:RemainingAmmo()
	return self.RemainingAmmo or 0
end

function ENT:SetSpareAmmo()
	return self.Magazine or 0
end



