function EFFECT:Think()
	return false
end

function EFFECT:Render()
end

print( "hi" )
function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local emitter = ParticleEmitter(pos)
	
	for x=0, math.Rand( 6, 16 ) do
		local particle2 = emitter:Add("decals/blood"..math.Rand( 1, 8 ), pos )
		particle2:SetVelocity(Vector( math.Rand(-40, 40), math.Rand(-40, 40),  math.Rand( 30, 70 ) ))
		particle2:SetColor(  math.Rand( 90, 220 ), 0, 0  )
		particle2:SetDieTime(math.Rand( 1.4 , 1.7 ))
		particle2:SetStartAlpha( math.Rand( 70, 120 ) )
		particle2:SetEndAlpha( 0 )
		particle2:SetStartSize( 4 )
		particle2:SetEndSize( 7 )
		particle2:SetRoll( 30 )
		particle2:SetRollDelta( math.Rand(-10, 10) )
		particle2:SetAirResistance(5)
		particle2:SetGravity( Vector(0, 0, -800 ) )
		particle2:SetCollide(true)
	end
	end
