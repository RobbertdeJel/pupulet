AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.StartupDelay = nil
function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_c4_planted.mdl") 
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.Entity:SetTrigger( true )
	self.StartupDelay = CurTime()+4
end

function ENT:Think()

	if self.StartupDelay and self.StartupDelay < CurTime() then
		local e = ents.FindInSphere( self.Entity:GetPos(), 130 )
		for a,pl in pairs(e) do
			-- Doesn't detonate for slow moving stalkers
			if (pl:IsPlayer() and pl:Team() == 3 and pl:Alive() ) then
				local trace = {}
				trace.start = self.Entity:GetPos()
				trace.endpos = pl:GetPos()+Vector(0,0,30)
				trace.filter = self.Entity
				local tr = util.TraceLine( trace )
				-- Checks if there's a clear view of the player
				if tr.Entity:IsValid() and tr.Entity == pl then
					self.Entity:EmitSound(self.WarningSound)
					timer.Simple(0.5,function() self:Explode() end)
					function self.Think() end
					end
				end
				if !IsValid(self:GetOwner()) or self:GetOwner():IsPlayer() and self:GetOwner():Team() ~= 4 then
					self:Remove()
			end
		end
	end
end

function ENT:Explode()
	-- BOOM!
	if not IsValid(self.Entity) then return end
	
	sound.Play( "explode_4", self.Entity:GetPos(), 130, 100 )
	
	local Ent = ents.Create("env_explosion")
	Ent:SetPos(self.Entity:GetPos())
	Ent:Spawn()
	Ent.Team = function() -- Correctly applies the whole 'no team damage' thing
		return 4
	end
	Ent.GetName = function()
		return "< Mine >"
	end
	Ent.Inflictor = self.Entity:GetClass()
	Ent:SetOwner(self:GetOwner())
	Ent:Activate()
	Ent:SetKeyValue("iMagnitude", 280 )
	Ent:SetKeyValue("iRadiusOverride", 250)
	Ent:Fire("explode", "", 0)
	
	-- Shaken, not stirred
	local shake = ents.Create( "env_shake" )
	shake:SetPos( self.Entity:GetPos() )
	shake:SetKeyValue( "amplitude", "800" ) -- Power of the shake effect
	shake:SetKeyValue( "radius", "300" )	-- Radius of the shake effect
	shake:SetKeyValue( "duration", "3" )	-- Duration of shake
	shake:SetKeyValue( "frequency", "128" )	-- Screenshake frequency
	shake:SetKeyValue( "spawnflags", "4" )	-- Spawnflags( In Air )
	shake:Spawn()
	shake:SetOwner( self:GetOwner() )
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	
	timer.Simple(0,function ()
		if not IsValid(self.Entity) then return end
		self:Remove() end)
end

function ENT:WallPlant(hitpos, forward)
	if (hitpos) then self.Entity:SetPos( hitpos ) end
    self.Entity:SetAngles( forward:Angle() + Angle( -90, 0, 180 ) )
end

function ENT:PhysicsCollide( data, phys ) 
	if ( !data.HitEntity:IsWorld() ) then return end
	phys:EnableMotion( false )
	phys:Sleep()
	self:WallPlant( nil, data.HitNormal:GetNormal() * -1 )
end
