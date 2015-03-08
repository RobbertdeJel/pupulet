AddCSLuaFile("shared.lua")

ENT.Type 			= "anim"
ENT.PrintName		= ""
ENT.Author			= "Rob"
ENT.Purpose			= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

util.PrecacheModel("models/Items/BoxMRounds.mdl")
util.PrecacheSound("items/ammo_pickup.wav")

if CLIENT then

	function ENT:Draw()
		self.BaseClass.Draw(self)
	end

	function ENT:OnRemove()
	end

	function ENT:Think()
	end
end

if SERVER then

	function ENT:Initialize()
		self.Entity:SetModel("models/Items/BoxMRounds.mdl")
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)	
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self.Entity:DrawShadow( true )
		self.active = false
		self:SetTrigger(true)
	end	
	
	function ENT:Use( ent )
		if  ent:IsValid() and ent:IsPlayer() and ent:Alive() and ent:Team() == 4 then
			local Wep = ent:GetActiveWeapon()

					ent:GiveAmmo( 20, "smg1" )
				
					
				self:Remove() 
			end
		end


end
