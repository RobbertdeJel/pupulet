AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self:DrawShadow(false)
	self:SetModel( "models/props_destruction/toxintube_straight_intact.mdl" )
	self.Initialized = true
	self.Selected = false
end	

function ENT:SelectHost()
	for k, v in pairs( player.GetAll() ) do
		if ( v:Alive() && !v.hasGass ) then
			v.hasGass = true;
			return v;
		end
	end
end

function ENT:Think()
/*
	if ( self.Initialized && !self.Selected ) then
		local host = player.GetAll()[ math.random( 1, #player.GetAll() ) ]
		if ( !host.hasGass ) then
			self:SetPos( host:GetPos() )
			self:SetParent( host )
			self.Selected = true
			self.Parent = host
			self.Parent.hasGass = true
			print( 'My host is...', host  )
		else
			print( 'no host found!' )
			self:Remove()
		end
		
	end
	if ( self.Parent && !self.Parent:Alive() ) then 
		print( "My host died ...", self.Parent )
		self.Parent.hasGass = false
		self:Remove()
	end
end
function ENT:OnRemove()
*/
end