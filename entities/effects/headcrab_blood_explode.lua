
print( 'hell yeah' )

local particleTable = {
	[ 1 ] = { particle = "decals/yblood1", sizeStart = 8, sizeEnd = 1, startAlpha = 180, endAlpha = 0, randXY = 120, randZMin = -10, randZMax = 220, color = Color( 80, 0, 0 ), rotRate = 16, lifeTimeMin = 1.8, lifeTimeMax = 2.9 },
	[ 2 ] = { particle = "decals/blood2", sizeStart = 0, sizeEnd = 6, startAlpha = 110, endAlpha = 0, randXY = 60, randZMin = -20, randZMax = 160, color = Color( 240, 240, 0 ), rotRate = 9, lifeTimeMin = 2.6, lifeTimeMax = 3.9 }
}



local function CollideCallback(oldparticle, hitpos, hitnormal)
	if oldparticle:GetDieTime() == 0 then return end
	oldparticle:SetDieTime(0)

	local pos = hitpos + hitnormal

	if math.random(3) == 3 then
		sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random( 4 )..".wav", hitpos, 50, math.Rand(95, 105))
		util.Decal("Impact.BloodyFlesh", pos, hitpos - hitnormal)
	end

end


function EFFECT:Init( data )
	
	local ent = data:GetEntity()
	if ( !IsValid( ent ) ) then return end
	local pos = ent:GetPos() + ent:OBBCenter() 
	local attPos = data:GetOrigin()
	local amount = math.Clamp( data:GetRadius(), 20, 70 )
	
	local newPos = ent:WorldToLocal( attPos ) * -1
	local emitter = ParticleEmitter( pos )
	for x=1, amount do
		local particleT = particleTable[ math.random( 2 ) ]
		local posX = math.Clamp( newPos.x + math.Rand( -particleT.randXY, particleT.randXY ), -200, 200 )
		local posY = math.Clamp( newPos.y + math.Rand( -particleT.randXY, particleT.randXY ), -200, 200 )
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