

local targetIDInfo = {
	colorEnemy = Color ( 255, 220, 140, 255 ),
	colorFriendly = Color( 0, 160, 0, 255 ),
	colorBlurFriendly = Color( 100, 20, 0, 220 ),
	colorBlurBlurEnemy = Color( 100, 20, 0, 220 ),
}

surface.CreateFont( "targetIDFont", {
	font = "akbar",
	size = ( ScrH() * 0.035 ) ,
	weight = 200,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )


local function getHealthColor( ent )
local fHealth, fMaxHealth = math.max( ent:Health(),0 ), ent:GetMaxHealth() 
local iPercentage = math.Clamp ( fHealth / fMaxHealth, 0, 1 )	
local colHealthBar = Color( 0, 160, 0, 255 ) 

	if 0.8 <= iPercentage then colHealthBar = Color ( 0, 160, 0, 255 ) end
	if 0.6 <= iPercentage &&  0.8 > iPercentage then colHealthBar = Color ( 146 ,142 ,22 ,255 ) end
	if 0.3 <= iPercentage &&  0.6 > iPercentage then colHealthBar = Color ( 166 ,79 ,3 ,255 ) end
	if 0.3 >= iPercentage  then colHealthBar = Color ( 153,7,4,math.sin( RealTime() * 6 ) * 127.5 + 127.5 ) end
	return colHealthBar
end

function drawTargetIDFriendly( pl, ent, trace )
	local targetPosFiendly = ent:LocalToWorld( ent:OBBCenter() )
	local screenPosFriendly = targetPosFiendly:ToScreen()
	local color, blurColor  = targetIDInfo.colorFriendly, targetIDInfo.colorBlurFriendly;
	local text = ent:Nick();
	local posX, posY = screenPosFriendly.x, screenPosFriendly.y;
	local blurX, blurY = math.Rand( -6, 6 ), math.Rand( -6, 6 )
	local healthTarget = ""
	local healthColor = getHealthColor( ent )
	
	if ( pl:GetHumanClass() == 5 ) then healthTarget = ent:Health();  end
	draw.SimpleText( text, "targetIDFont", ( posX - 20 ) + blurX, posY + blurY , blurColor )
	draw.SimpleText( text, "targetIDFont", posX - 20, posY, color )
	draw.SimpleText( healthTarget, "targetIDFont", ( posX - 10 ) + blurX, ( posY + 25 ) + blurY , blurColor )
	draw.SimpleText( healthTarget, "targetIDFont", ( posX - 10 ), posY + 25, healthColor )
	
end

function drawTargetIDEnemy( pl, ent, trace )
	local targetPosFiendly = ent:LocalToWorld( ent:OBBCenter() );
	local screenPosFriendly = targetPosFiendly:ToScreen();
	local color, blurColor  = targetIDInfo.colorEnemy, targetIDInfo.colorBlurBlurEnemy;
	local text = ent:Nick();
	local posX, posY = screenPosFriendly.x, screenPosFriendly.y;
	local posXHealth = screenPosFriendly.x - 40
	local blurX, blurY = math.Rand( -6, 6 ), math.Rand( -6, 6 )
	local healthTarget = "UNKNOWN";
	local healthColor = getHealthColor( ent );
	
	
	if ( pl:GetHumanClass() == 3 ) then healthTarget = ent:Health(); posXHealth = screenPosFriendly.x - 10  end
	draw.SimpleText( text, "targetIDFont", ( posX - 20 ) + blurX, posY + blurY , blurColor );
	draw.SimpleText( text, "targetIDFont", posX - 20, posY, color );
	draw.SimpleText( healthTarget, "targetIDFont", posXHealth + blurX, ( posY + 25 ) + blurY , blurColor );
	draw.SimpleText( healthTarget, "targetIDFont", posXHealth, posY + 25, color );
	
end

hook.Add( "HUDPaint", "targetIDHandeler", function()
	local pl = LocalPlayer();
	local tr = util.GetPlayerTrace( pl );
	local trace = util.TraceLine( tr );
	if (!trace.Hit) then return end
	if (!trace.HitNonWorld) then return end
	local ent = trace.Entity;
		if( IsValid( pl ) && pl:Team() == 4 && ent:IsPlayer() && ent:Alive() && pl:GetPos():Distance( ent:GetPos() ) <= 600 ) then
			if( IsValid( ent ) && pl:Team() == ent:Team() ) then
				drawTargetIDFriendly( pl, ent, trace );
			end
			if ( IsValid( ent )  && pl:Team() ~= ent:Team() ) then
				drawTargetIDEnemy( pl, ent, trace );
			end
		end
end )