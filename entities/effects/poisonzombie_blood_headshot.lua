
local particleTable = {
	[ 1 ] = { particle = "decals/blood1", sizeStart = 3, sizeEnd = 8, startAlpha = 180, endAlpha = 0, randXY = 62, randZMin = 110, randZMax = 220, color = Color( 80, 0, 0 ), rotRate = 16, lifeTimeMin = 1.8, lifeTimeMax = 2.9 },
	[ 2 ] = { particle = "decals/blood2", sizeStart = 4, sizeEnd = 6, startAlpha = 110, endAlpha = 0, randXY = 32, randZMin = 120, randZMax = 230, color = Color( 55, 0, 0 ), rotRate = 9, lifeTimeMin = 1.6, lifeTimeMax = 2.9 },
	[ 3 ] = { particle = "decals/blood3", sizeStart = 9, sizeEnd = 4, startAlpha = 240, endAlpha = 0,randXY = 68, randZMin = 130, randZMax = 240, color = Color( 20, 0, 0 ), rotRate = 14, lifeTimeMin = 2.8, lifeTimeMax = 3.1 },
	[ 4 ] = { particle = "decals/blood4", sizeStart = 15, sizeEnd = 7, startAlpha = 255, endAlpha = 0,randXY = 58, randZMin = 140, randZMax = 250, color = Color( 190, 0, 0 ), rotRate = 20, lifeTimeMin = 2.6, lifeTimeMax = 3.4 }, 
	[ 5 ] = { particle = "decals/blood5", sizeStart = 0, sizeEnd = 12, startAlpha = 180, endAlpha = 0,randXY = 78, randZMin = 150, randZMax = 260, color = Color( 60, 0, 0 ), rotRate = 1.4, lifeTimeMin = 2.6, lifeTimeMax = 3.6 },
	[ 6 ] = { particle = "decals/blood6", sizeStart = 0, sizeEnd = 5, startAlpha = 190, endAlpha = 0,randXY = 32, randZMin = 160, randZMax = 270, color = Color( 80, 0, 0 ), rotRate = 30, lifeTimeMin = 2.7, lifeTimeMax = 3.1 },
	[ 7 ] = { particle = "decals/blood7", sizeStart = 9, sizeEnd = 2, startAlpha = 255, endAlpha = 0,randXY = 68, randZMin = 170, randZMax = 280, color = Color( 120, 0, 0 ), rotRate = 14, lifeTimeMin = 2.5, lifeTimeMax = 3.2 },
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
	local pos = ent:GetBonePosition( ent:LookupBone( "ValveBiped.Bip01_Spine4" ) ) 
	local attPos = data:GetOrigin() 
	local amount = math.Clamp( data:GetRadius(), 89, 240 )
	local newPos = ent:WorldToLocal( attPos ) * -1
	
	local emitter = ParticleEmitter( pos )
	for x=1, amount do
		local tparticleT = particleTable[ math.random( 7 ) ]
		local posX = newPos.x + math.Rand( -tparticleT.randXY, tparticleT.randXY )
		local posY = newPos.y + math.Rand( -tparticleT.randXY, tparticleT.randXY )
		local posZ = math.Rand( tparticleT.randZMin, tparticleT.randZMax )
		local particle = emitter:Add( tparticleT.particle, pos  )
			particle:SetVelocity( Vector( posX, posY, posZ  )  )
			particle:SetColor( tparticleT.color.r, tparticleT.color.g, tparticleT.color.b )
			particle:SetGravity( Vector(0, 0, -500 ) )
			particle:SetCollide( true )
			particle:SetDieTime( math.Rand( tparticleT.lifeTimeMin , tparticleT.lifeTimeMax ) )
			particle:SetStartAlpha( tparticleT.startAlpha )
			particle:SetEndAlpha( tparticleT.endAlpha )
			particle:SetStartSize( tparticleT.sizeStart )
			particle:SetEndSize( tparticleT.sizeEnd )
			particle:SetRollDelta( math.Rand( -tparticleT.rotRate, tparticleT.rotRate ) )
			particle:SetCollideCallback( CollideCallback )
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end