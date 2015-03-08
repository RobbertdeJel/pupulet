include("shared.lua")

ENT.thinkTimer = 0

local particleTable = {
	[ 1 ] = { particle = "particle/smokesprites_0001", sizeStart = 0, sizeEnd = 96, airRecis = 90, startAlpha = 180, endAlpha = 0, randXY = 46, randZMin = 34, randZMax = 72, color = Color( 0, 80, 0 ), rotRate = 0.9, lifeTimeMin = 1.8, lifeTimeMax = 2.9 },
	[ 2 ] = { particle = "particle/smokesprites_0002", sizeStart = 0, sizeEnd = 90, airRecis = 76, startAlpha = 110, endAlpha = 0, randXY = 24, randZMin = 24, randZMax = 62, color = Color( 0, 120, 0 ), rotRate = 0.6, lifeTimeMin = 1.6, lifeTimeMax = 2.2 },
	[ 3 ] = { particle = "particle/smokesprites_0003", sizeStart = 0, sizeEnd = 140, airRecis = 49, startAlpha = 130, endAlpha = 0,randXY = 36, randZMin = 39, randZMax = 42, color = Color( 0, 90, 0 ), rotRate = 0.6, lifeTimeMin = 1.8, lifeTimeMax = 2.4 },
	[ 4 ] = { particle = "particle/smokesprites_0004", sizeStart = 0, sizeEnd = 100, airRecis = 59, startAlpha = 160, endAlpha = 0,randXY = 42, randZMin = 31, randZMax = 68, color = Color( 0, 60, 0 ), rotRate = 0.2, lifeTimeMin = 1.6, lifeTimeMax = 2.9 },
	[ 5 ] = { particle = "particle/smokesprites_0007", sizeStart = 0, sizeEnd = 160, airRecis = 79, startAlpha = 180, endAlpha = 0,randXY = 46, randZMin = 16, randZMax = 56, color = Color( 0, 70, 0 ), rotRate = 1.4, lifeTimeMin = 1.6, lifeTimeMax = 2.2 },
	[ 6 ] = { particle = "particle/smokesprites_0008", sizeStart = 0, sizeEnd = 60, airRecis = 46, startAlpha = 190, endAlpha = 0,randXY = 49, randZMin = 12, randZMax = 48, color = Color( 0, 90, 0 ), rotRate = 1, lifeTimeMin = 1.7, lifeTimeMax = 2.4 },
	[ 7 ] = { particle = "particle/particle_glow_03", sizeStart = 0, sizeEnd = 4, airRecis = 4, startAlpha = 255, endAlpha = 0,randXY = 69, randZMin = 16, randZMax = 64, color = Color( 0, 255, 0 ), rotRate = 0, lifeTimeMin = 1.5, lifeTimeMax = 2.8 },
}


function ENT:Think()	
	if( self.thinkTimer > CurTime() ) then return end
	local pos = self:GetPos()
		
		
	local emitter = ParticleEmitter( pos )

	local vecRan = VectorRand():GetNormalized()
	local chance = math.random( 1, 7 )
	vecRan = vecRan * math.Rand( 20, 40 )
	vecRan.z = math.Rand( 10, 60 )
	emitter:SetNearClip( 48, 64 )
			local particle = emitter:Add( particleTable[ chance ].particle, pos + vecRan )
			particle:SetVelocity( Vector( math.Rand( -particleTable[ chance ].randXY, particleTable[ chance ].randXY ), math.Rand( -particleTable[ chance ].randXY, particleTable[ chance ].randXY ),  math.Rand( particleTable[ chance ].randZMin, particleTable[ chance ].randZMax ) )  )
			particle:SetColor( particleTable[ chance ].color.r, particleTable[ chance ].color.g, particleTable[ chance ].color.b )
			particle:SetAirResistance( particleTable[ chance ].airRecis )
			particle:SetCollide( true )
			particle:SetDieTime( math.Rand( particleTable[ chance ].lifeTimeMin , particleTable[ chance ].lifeTimeMax ) )
			particle:SetStartAlpha( particleTable[ chance ].startAlpha )
			particle:SetEndAlpha( particleTable[ chance ].endAlpha )
			particle:SetStartSize( particleTable[ chance ].sizeStart )
			particle:SetEndSize( particleTable[ chance ].sizeEnd )
			particle:SetRollDelta( math.Rand( -particleTable[ chance ].rotRate, particleTable[ chance ].rotRate ) )
		emitter:Finish()
				
	self.thinkTimer = CurTime() + math.Rand( 0.05, 0.25 )
end

function ENT:Draw()
end