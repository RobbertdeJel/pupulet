
-- © Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

include("shared.lua")
ENT.IsCrate = true

local ents = ents
local util = util
local render = render
local pairs = pairs
local table = table

function ENT:Draw()
	self:DrawModel()
	self:DrawEntityOutline()
end

local matOutlineWhite = Material( "white_outline" )


/*----------------------------------------------------
    Used to control the colors for outline thing
-----------------------------------------------------*/

function ENT:OnRemove()
end

/*----------------------------------------------
    Returns entity children / clientside
-----------------------------------------------*/

function ENT:GetChildren()
	local Parent, Children = self.Entity, {}
	for k,v in pairs ( ents.FindInSphere ( self.Entity:GetPos(), 100 ) ) do
		if IsValid( v ) and v:GetClass() == "prop_physics_multiplayer" then
			if IsValid( v:GetOwner() ) and v:GetOwner() == Parent then
				table.insert ( Children, v )
				table.insert ( Children, Parent )
			end
		end
	end
	
	return Children
end
 
/*--------------------------------------- 
	Makes that entity outline 
----------------------------------------*/

local matOutlineWhite = Material("white_outline")
local ScaleNormal = 1

function ENT:DrawEntityOutline()
	if ( IsValid( pl ) and pl:Team() != 4 ) then return end
	local ScaleOutline = 1 + math.Rand( 0.027, 0.03 )
	local Resupplytime = math.ceil( pl:GetSuppliesTime() - CurTime() ) 
	local LineColor = Color ( math.abs ( 200 * math.sin ( CurTime() * 3 ) ), 0,0, 255 )
	local text = "Supplies are ready in:  " ..string.ToMinutesSeconds( Resupplytime )
	if pl:GetSuppliesTime() < CurTime() then
		LineColor = Color ( 0, math.abs ( 200 * math.sin ( CurTime() * 3 ) ),0, 255 )
		text = "     Supplies Are Ready!"
	end

	for k, v in pairs(self:GetChildren()) do

		render.SuppressEngineLighting(true)
		render.SetAmbientLight(1, 1, 1)

		render.SetColorModulation( LineColor.r/255 , LineColor.g/255, LineColor.b/255)

		v:SetModelScale(ScaleOutline, 0)
		--self:SetModelScale(ScaleOutline, 0)
		render.ModelMaterialOverride(matOutlineWhite)
		v:DrawModel()
		--self:DrawModel()

		render.ModelMaterialOverride()
		v:SetModelScale(ScaleNormal, 0)
		--self:SetModelScale(ScaleNormal, 0)
		render.SuppressEngineLighting(false)
		render.SetColorModulation(1, 1, 1)

		v:DrawModel()
		--self:DrawModel()
	end 
	
end
