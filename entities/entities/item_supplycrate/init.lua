AddCSLuaFile ("shared.lua")
AddCSLuaFile ("cl_init.lua")

include ("shared.lua")

//Normal set data
ENT.Table = {
	["AmmoLeft"] = { Model = "models/items/item_item_crate.mdl", Position = Vector ( 0,0,0 ), Angles = Angle ( 0.019, -168.486 ,0.100 ) },
	["AmmoRight"] = { Model = "models/items/item_item_crate.mdl", Position = Vector ( -3.8088 ,37.7378 ,0 ), Angles = Angle ( -0.015 ,-179.685, 0.014 ) },
	["AmmoUp"] = { Model = "models/items/item_item_crate.mdl", Position = Vector ( -2.1039 ,18.8135 ,23.98 ), Angles = Angle ( 0.032 ,-175.133 ,0.143 ) },
	["Shotgun"] = { Model = "models/weapons/w_shot_xm1014.mdl", Position = Vector ( -2.1762 ,16.9928 ,48.5 ), Angles = Angle ( -1.297 ,60 ,-89.158 ) },
	["Ammo"] = { Model = "models/items/boxbuckshot.mdl", Position = Vector ( -1.6052 ,-6.7138 ,24 ), Angles = Angle ( -0.336 , -115 ,0.072 ) },
	["Vial"] = { Model = "models/healthvial.mdl", Position = Vector ( -9.5952 ,43.9023 ,25.5 ), Angles = Angle ( 0.726 ,-66.560 ,-90.018 ) },
}

//Switch offset
ENT.Offset = {
	["AmmoRight"] = Vector ( 3 ,10.5 ,0 ),
	["AmmoUp"] = Vector ( 1 ,8 ,0 ),
	["Shotgun"] = Vector ( 23 ,5 ,0 ),
	["Vial"] = Vector ( 0 ,8 ,0 ),
}

ENT.Children = {}

//Starts in original angle and position
ENT.Switch = false
ENT.IsCrate = true

//Precache their models
for k,v in pairs ( ENT.Table ) do
	util.PrecacheModel ( v.Model )
end

function ENT:Initialize()
	//if the composite is switched, then set the angles inverse
	local aOffset, vCenter = Angle ( 0,0,0 ), Vector ( 0, 20, 0 )
	if self.Switch then
		aOffset, vCenter = Angle ( 0, -90, 0 ), Vector ( 20, 0, 0 )
	end
	
	//Spawn the main parent prop 
	self:SetModel ( self.Table["AmmoLeft"].Model )
	self:SetAngles ( self.Table["AmmoLeft"].Angles + aOffset )
	self:SetPos( self:GetPos() - vCenter )
	self:PhysicsInit( SOLID_VPHYSICS )
		
	
	//Effect for parent
	local effectdata = EffectData()
	effectdata:SetEntity( self )
	util.Effect( "ammo_spawn_effect", effectdata, true, true )
	
	if self.Switch then
		aOffset = Angle ( 0, 90, 0 )
	end
	
	//Freeze the main prop
	local Phys = self:GetPhysicsObject()
	if Phys:IsValid() then 
		Phys:EnableMotion ( false )
		Phys:Wake()
	end
	
	//Now spawn the rest
	for k,v in pairs ( self.Table ) do
		if k != "AmmoLeft" then
			local Ent = ents.Create ("prop_physics_multiplayer")
			Ent:SetModel ( v.Model )
			Ent:SetAngles ( v.Angles + aOffset )
			Ent.IsCrate = true

			//Position offset
			local Offset = Vector ( 0,0,0 )
			if self.Switch then
				if self.Offset[k] then
					Offset = self.Offset[k]
				end
			end
			
			//Actually set position
			Ent:SetPos ( self:GetPos() + v.Position + Offset )
			Ent:SetParent( self )
			Ent:SetKeyValue ( "minhealthdmg", 600 )
			Ent:SetKeyValue ( "PerformanceMode", 3 ) 
			
			//Delete the children when the parent is removed
			Ent:SetOwner ( self )
			table.insert ( self.Children, Ent )
			
			//Physics properties
			Ent:PhysicsInit( SOLID_VPHYSICS )
			Ent:DrawShadow ( false )
			
			//Prevent unnecessary collisions
			if k == "Ammo" or k == "Shotgun" or k == "Vial" then
				Ent:SetCollisionGroup ( COLLISION_GROUP_DEBRIS )
			end
			
			Ent:Spawn()
			
			//Effect for parent
			local effectdata = EffectData()
			effectdata:SetEntity( Ent )
			util.Effect( "ammo_spawn_effect", effectdata, true, true )
			
			//Freeze them
			local Phys = Ent:GetPhysicsObject()
			if Phys:IsValid() then 
				Phys:EnableMotion ( false )
				Phys:Wake()
			end
		end
	end
	
	
end

/*-------------------------------------------
   Returns entity children / serverside
---------------------------------------------*/
function ENT:GetChildren()
	return self.Children
end