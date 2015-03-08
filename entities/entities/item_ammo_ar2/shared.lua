AddCSLuaFile("shared.lua")

ENT.Type 			= "anim"
ENT.PrintName		= ""
ENT.Author			= "Rob"
ENT.Purpose			= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

util.PrecacheModel("models/items/combine_rifle_cartridge01.mdl")
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
		self.Entity:SetModel("models/items/combine_rifle_cartridge01.mdl")
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)	
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self.Entity:DrawShadow( true )
		self:SetTrigger(true)
	end	
	
	function ENT:Use( ent )
		if  ent:IsValid() and ent:IsPlayer() and ent:Alive() and ent:Team() == 4 then
			local Wep = ent:GetActiveWeapon()

					ent:GiveAmmo( 30, "ar2" )
				
					
				self:Remove() 
			end
		end


end
