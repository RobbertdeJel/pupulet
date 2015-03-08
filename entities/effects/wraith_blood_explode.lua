
local particleTable = {
	[ 1 ] = { particle = "decals/blood1", sizeStart = 15, sizeEnd = 13, startAlpha = 180, endAlpha = 0, randXY = 78, randZMin = -10, randZMax = 220, color = Color( 80, 0, 0 ), rotRate = 16, lifeTimeMin = 1.8, lifeTimeMax = 2.9 },
	[ 2 ] = { particle = "decals/blood2", sizeStart = 0, sizeEnd = 18, startAlpha = 110, endAlpha = 0, randXY = 60, randZMin = -20, randZMax = 360, color = Color( 55, 0, 0 ), rotRate = 9, lifeTimeMin = 2.6, lifeTimeMax = 3.9 },
	[ 3 ] = { particle = "decals/blood3", sizeStart = 7, sizeEnd = 12, startAlpha = 240, endAlpha = 0,randXY = 74, randZMin = -10, randZMax = 320, color = Color( 80, 0, 0 ), rotRate = 14, lifeTimeMin = 1.8, lifeTimeMax = 3.1 },
	[ 4 ] = { particle = "decals/blood4", sizeStart = 0, sizeEnd = 18, startAlpha = 255, endAlpha = 0,randXY = 68, randZMin = -10, randZMax = 290, color = Color( 65, 0, 0 ), rotRate = 20, lifeTimeMin = 1.6, lifeTimeMax = 2.4 },
	[ 5 ] = { particle = "decals/blood5", sizeStart = 4, sizeEnd = 12, startAlpha = 180, endAlpha = 0,randXY = 54, randZMin = -10, randZMax = 210, color = Color( 40, 0, 0 ), rotRate = 1.4, lifeTimeMin = 1.6, lifeTimeMax = 2.6 },
	[ 6 ] = { particle = "decals/blood6", sizeStart = 0, sizeEnd = 16, startAlpha = 190, endAlpha = 0,randXY = 88, randZMin = -25, randZMax = 290, color = Color( 80, 0, 0 ), rotRate = 30, lifeTimeMin = 2.7, lifeTimeMax = 4.1 },
	[ 7 ] = { particle = "decals/blood7", sizeStart = 14, sizeEnd = 19, startAlpha = 255, endAlpha = 0,randXY = 120, randZMin = -31, randZMax = 260, color = Color( 20, 0, 0 ), rotRate = 14, lifeTimeMin = 1.5, lifeTimeMax = 2.9 },
}



local function CollideCallback(oldparticle, hitpos, hitnormal)
	if oldparticle:GetDieTime() == 0 then return end
	oldparticle:SetDieTime(0)

	local pos = hitpos + hitnormal

	if math.random(3) == 3 then
		sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", hitpos, 50, math.Rand(95, 105))
		util.Decal("Blood", pos, hitpos - hitnormal)
	end

end


function EFFECT:Init( data )
	
	local ent = data:GetEntity()
	if ( !IsValid( ent ) ) then return end
	local pos = ent:GetPos() + ent:OBBCenter() 
	local attPos = data:GetOrigin()
	local amount = math.Clamp( data:GetRadius(), 60, 200 )
	
	local newPos = ent:WorldToLocal( attPos ) * -1
	local emitter = ParticleEmitter( pos )
	for x=1, amount do
		local particleT = particleTable[ math.random( 7 ) ]
		local posX = math.Clamp( newPos.x + math.Rand( -particleT.randXY, particleT.randXY ), -400, 400 )
		local posY = math.Clamp( newPos.y + math.Rand( -particleT.randXY, particleT.randXY ), -400, 400 )
		local particle = emitter:Add( particleT.particle, pos )
			particle:SetVelocity( Vector( posX, posY, math.Rand( particleT.randZMin, particleT.randZMax ) )  )
			particle:SetColor( particleT.color.r, particleT.color.g, particleT.color.b )
			particle:SetGravity( Vector(0, 0, -500 ) )
			particle:SetCollide( true )
			particle:SetDieTime( math.Rand( particleT.lifeTimeMin , particleT.lifeTimeMax ) )
			particle:SetStartAlpha( particleT.startAlpha )
			particle:SetEndAlpha( particleT.endAlpha )
			particle:SetStartSize( particleT.sizeStart )
			particle:SetEndSize( particleT.sizeEnd )
			particle:SetRollDelta( math.Rand( -particleT.rotRate, particleT.rotRate ) )
			particle:SetCollideCallback(CollideCallback)
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end