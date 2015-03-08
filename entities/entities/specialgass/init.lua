AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.poisonTimer = 0
function ENT:Initialize()
	pos = self:GetPos()
	self:DrawShadow(false)
	self:SetAngles( Angle( 90, 0, 0 ) )
	self:SetModel( "models/props_pipes/destroyedpipes01d.mdl" )
	self:SetModelScale( 1.25, 0 )
	self:SetColor( Color( 120, 120, 120, 255 ) )
		
	self:PhysicsInit(SOLID_VPHYSICS)
	
	self:Fire("attack", "", 1.5)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end
end	

local tr = {
	start = nil, 
	endpos = nil, 
	filter = nil,
} 

function ENT:IsVisiblePlayer( thing )

tr.start = self:GetPos()
tr.endpos = thing:GetPos()
tr.filter = function( ent ) if ent == thing then return true end end 
local trace = util.TraceLine( tr )

	if !trace.HitWorld || trace.Entity:IsPlayer()  then 
		return true
	else
		return false
	end

end

function ENT:Think()

if ( self.poisonTimer <= CurTime() ) then
	self.poisonTimer = CurTime() + math.Rand( 1.2, 2.5 )
	local ent = ents.FindInSphere( self:GetPos(), 250 )
		for _, v in pairs( ent ) do 
			if ( IsValid( v ) && v:IsPlayer() && v:Alive() ) then
				if v:Team() == 3 && self:IsVisiblePlayer( v )  then
					local randomHeal = math.random( 9, 25 )
					if v:Health() <= ( v:GetMaxHealth() - randomHeal ) then
						v:SetHealth( v:Health() + randomHeal )
					else
						v:SetHealth( v:GetMaxHealth() )
					end
				end
				if v:Team() == 4 && self:IsVisiblePlayer( v ) then
					v:TakeDamage( math.random( 4, 9 ) )
				end
			end
		end
	end
	
end


function ENT:OnRemove()

end