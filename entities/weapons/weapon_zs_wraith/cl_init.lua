include("shared.lua")

SWEP.PrintName = "Wraith"
SWEP.ViewModelFOV = 47


function SWEP:Think()
	self:ManipulateBonesScale( 0, 50, Vector( 0.6, 0.6, 0.9 ) )
	self:ManipulateBonesPos( 4, 24, Vector( -3, -1, 0.9 ) )
	self:VieuwModelEffect()

end