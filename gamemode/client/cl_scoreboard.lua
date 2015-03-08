include( "client/object_player_exstended_cl.lua" )  
local w, h = ScrW(), ScrH()
local playersInTable = {}

local SCORE_BOARD = {}
SCORE_BOARD.autoUpdate = false // does it update when it's active?
SCORE_BOARD.thinkDelay = 0.5 // how quick should it update?


//Don't touch these unless you know what they do.
SCORE_BOARD.thinkTime = 0
SCORE_BOARD.isCreated = false
SCORE_BOARD.isActive = false


SCORE_BOARD.RealTimeReplace = 0

SCORE_BOARD.mainPanelBody = { 
		width = ( w * 0.3 ),
		height = h,
		wPos = 0,	// no need for this now but you might need it later.
		hPos = 0,	// no need for this now but you might need it later.
		color = Color( 0, 0, 0, 140 ),
		colorTop = Color( 0, 0, 0, 255 )
}

SCORE_BOARD.InfoLabel = {
	width = ( w * 0.3 ),
	height = ( h * 0.025 ),
	wPos = 0,
	hPos = ( h * 0.176 ),
	color = Color ( 0, 0, 0, 255 ),
	namePos = w * 0.035,
	killsPos = w * 0.092,
	classPos = w * 0.145,
	pingPos = w * 0.234
}

SCORE_BOARD.scrollPanel = { 
		width = ( w * 0.3 ),
		height = ( h * 0.5 ),
		wPos = 0,	// no need for this now but you might need it later.
		hPos = ( h * 0.2 ),	// no need for this now but you might need it later.
		color = Color( 0, 0, 0, 255 )
}

SCORE_BOARD.playerLabel = {
	width = ( w * 0.3 ),
	hight = ( h * 0.05 ),
	wPos = 0,
	hPos = 0,
	color = Color( 0, 0, 0, 180 ),
	textColor = Color( 255, 255, 255, 255 ),
	outlineColor = Color( 167, 62, 0, 220 )
	
}


local classNAmeHuman = {
	[ 1 ] = "Sharpshooter",
	[ 2 ] = "Support",
	[ 3 ] = "Commando",
	[ 4 ] = "Berserker",
	[ 5 ] = "Medic",
	[ 6 ] = "Engineer"
}


local classNameZombie = {
	[ 1 ] = "Normal Zombie",
	[ 2 ] = "Headcrab",
	[ 3 ] = "Wraith",
	[ 4 ] = "Fast Zombie",
	[ 5 ] = "Poison Headcrab",
	[ 6 ] = "Poison Zombie",
	[ 7 ] = "Zombine"
}


function SCORE_BOARD:createMainPanel()
	 zs_MAIN_BODY = vgui.Create( 'DFrame' )
		zs_MAIN_BODY:SetSize( SCORE_BOARD.mainPanelBody.width, SCORE_BOARD.mainPanelBody.height )
		zs_MAIN_BODY:SetPos( SCORE_BOARD.mainPanelBody.wPos, SCORE_BOARD.mainPanelBody.hPos )
		zs_MAIN_BODY:ShowCloseButton( false )
		zs_MAIN_BODY:SetDraggable( false )
		zs_MAIN_BODY:MakePopup()
		zs_MAIN_BODY:SetTitle( '' )
		zs_MAIN_BODY.Paint = function()
			draw.RoundedBox( 0, 0, 0, zs_MAIN_BODY:GetWide(), zs_MAIN_BODY:GetTall(), SCORE_BOARD.mainPanelBody.color  )
			draw.RoundedBox( 0, 0, 0,  zs_MAIN_BODY:GetWide(), h * 0.05, SCORE_BOARD.mainPanelBody.colorTop  )
			draw.RoundedBox( 0, 0, h - (  h * 0.3 ),  zs_MAIN_BODY:GetWide(), h * 0.025, SCORE_BOARD.mainPanelBody.colorTop  )
			draw.SimpleText( "Rob Zombie Survival", 'ScoreboardDefaultTitle', zs_MAIN_BODY:GetWide() * 0.025, h * 0.015, Color( 0, 120, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.SimpleText( "Created by Robbert 'Rob' de Jel", 'ScoreboardDefault', zs_MAIN_BODY:GetWide() * 0.025, h * 0.035, Color( 0, 120, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
			
			local infoLoabel = zs_MAIN_BODY:Add( 'DLabel' )
				infoLoabel:SetSize( SCORE_BOARD.InfoLabel.width, SCORE_BOARD.InfoLabel.height )
				infoLoabel:SetPos( SCORE_BOARD.InfoLabel.wPos, SCORE_BOARD.InfoLabel.hPos )
				infoLoabel:SetText( '' )
				infoLoabel.Paint = function()
					draw.RoundedBox( 0, -1, -1, infoLoabel:GetWide(), infoLoabel:GetTall() , SCORE_BOARD.InfoLabel.color  )
					draw.SimpleText( "Name", 'ScoreboardDefault', SCORE_BOARD.InfoLabel.namePos, infoLoabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					draw.SimpleText( "Kills", 'ScoreboardDefault', SCORE_BOARD.InfoLabel.killsPos, infoLoabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					draw.SimpleText( "Class", 'ScoreboardDefault', SCORE_BOARD.InfoLabel.classPos, infoLoabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					draw.SimpleText( "Ping", 'ScoreboardDefault', SCORE_BOARD.InfoLabel.pingPos, infoLoabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
			
			local teamMeates = zs_MAIN_BODY:Add( "DScrollPanel" )
				teamMeates:SetSize( SCORE_BOARD.scrollPanel.width, SCORE_BOARD.scrollPanel.height )
				teamMeates:SetPos( SCORE_BOARD.scrollPanel.wPos, SCORE_BOARD.scrollPanel.hPos )
				teamMeates.Paint = function()
					//draw.RoundedBox( 0, 0, 0, teamMeates:GetWide(), teamMeates:GetTall(), Color( 0, 0, 0, 255 ) )
				end
				for k, v in pairs( playersInTable ) do
					local playerLabel = teamMeates:Add( 'DFrame' )
						playerLabel:Dock( TOP )												
						playerLabel:SetZPos( v.zPos )
						playerLabel:ShowCloseButton( false )
						playerLabel:SetDraggable( false )
						playerLabel:SetTitle( '' )
						playerLabel:SetHeight( h * 0.04 )
						playerLabel:DockMargin( 2, 1, 4, 0 )
						playerLabel.Paint = function()
							if( !IsValid( v.savePlayer ) ) then return end
							draw.RoundedBox( 4, 0, 0, playerLabel:GetWide(), playerLabel:GetTall() , v.hoverColor  )
							draw.RoundedBox( 4, 2, 2, playerLabel:GetWide() - 4, playerLabel:GetTall() - 4, SCORE_BOARD.playerLabel.color  )
							draw.SimpleText( k, 'ScoreboardDefault', w * 0.04, playerLabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							draw.SimpleText( v.savePlayer:Frags(), 'ScoreboardDefault', w * 0.09, playerLabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							draw.SimpleText( v.savePlayer:Ping(), 'ScoreboardDefault', playerLabel:GetWide() * 0.8, playerLabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							draw.SimpleText( v.classPlayer, 'ScoreboardDefault', playerLabel:GetWide() * 0.5, playerLabel:GetTall() * 0.5, SCORE_BOARD.playerLabel.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						end
						playerLabel.Think = function() 
							if ( playerLabel:IsHovered() ) then 
								if ( v.savePlayer:Team() == 1 || v.savePlayer:Team() == 4 ) then
									v.hoverColor = Color( math.abs( math.sin( ( RealTime() - SCORE_BOARD.RealTimeReplace ) * 2 ) ) * 40, math.abs( math.sin( ( RealTime() - SCORE_BOARD.RealTimeReplace ) * 2 ) ) * 140, math.abs( math.sin( ( RealTime() - SCORE_BOARD.RealTimeReplace ) * 2 ) ) * 317, 180 )
								end
								if ( v.savePlayer:Team() == 2 || v.savePlayer:Team() == 3 ) then
									v.hoverColor = Color( math.abs( math.sin( ( RealTime() - SCORE_BOARD.RealTimeReplace ) * 2 ) ) * 40, math.abs( math.sin( ( RealTime() - SCORE_BOARD.RealTimeReplace ) * 2 ) ) * 317, math.abs( math.sin( ( RealTime() - SCORE_BOARD.RealTimeReplace ) * 2 ) ) * 40, 180 )
								end
							end
							if ( SCORE_BOARD.autoUpdate && SCORE_BOARD.thinkTime <= CurTime() ) then
								SCORE_BOARD.thinkTime = CurTime() + SCORE_BOARD.thinkDelay
								
								SCORE_BOARD:updatePlayers() 
							end
						end
						playerLabel.OnCursorEntered = function()
							SCORE_BOARD.RealTimeReplace = RealTime()
							v.hoverColor = SCORE_BOARD.playerLabel.color
						end
						playerLabel.OnCursorExited = function()
							SCORE_BOARD.RealTimeReplace = 0
							v.hoverColor = SCORE_BOARD.playerLabel.color
						end
						
					
					local 	playerAvatarButton = vgui.Create( "DFrame", playerLabel )
						playerAvatarButton:SetSize( w * 0.02, h * 0.035 )
						playerAvatarButton:SetPos( w * 0.002, h * 0.003 )
						playerAvatarButton:ShowCloseButton( false )
						playerAvatarButton:SetDraggable( false )
						playerAvatarButton:SetTitle( '' )
						playerAvatarButton.OnMousePressed = function() v.savePlayer:ShowProfile() end
						
						
						local Avatar = vgui.Create( "AvatarImage", playerAvatarButton )
						Avatar:SetSize( w * 0.02, h * 0.035 )
						Avatar:SetMouseInputEnabled( false )
						Avatar:SetPlayer( v.savePlayer )
				end
				
end


function SCORE_BOARD:updatePlayers()
playersInTable = {}
local players = player.GetAll()
if ( LocalPlayer():Team() == 1 || LocalPlayer():Team() == 4 ) then
	for k, v in pairs( players ) do
//	if ( !IsValid( v ) || !v.SteamID || !v.Frags || !v.Nick ) then continue end
		if ( v:Team() == 2 || v:Team() == 3 ) then continue end
		playersInTable[ v:Nick() ] = { savePlayer =  v, hoverColor =  SCORE_BOARD.playerLabel.color, zPos = ( v:Frags() *-50 ), classPlayer = classNAmeHuman[ v:GetHumanClass() ] }
	end
end
if ( LocalPlayer():Team() == 2 || LocalPlayer():Team() == 3 ) then
	for k, v in pairs( players ) do
//	if ( !IsValid( v ) || !v.SteamID || !v.Frags || !v.Nick ) then continue end
		if ( v:Team() == 1 || v:Team() == 4 ) then continue end
		playersInTable[ v:Nick() ] = { savePlayer =  v, hoverColor =  SCORE_BOARD.playerLabel.color, zPos = ( v:Frags() *-50 ), classPlayer = classNameZombie[ v:GetZombieClass() ] }
	end
end
end

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardShow( )
	Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()

	if ( !SCORE_BOARD.isActive && !SCORE_BOARD.isCreated ) then
		SCORE_BOARD.isActive = true
		SCORE_BOARD.isCreated = true
		SCORE_BOARD:updatePlayers()
		SCORE_BOARD:createMainPanel()
	end
end

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardHide( )
	Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()

	if ( SCORE_BOARD.isCreated && SCORE_BOARD.isActive ) then
		zs_MAIN_BODY:Remove()
		SCORE_BOARD:updatePlayers()
		SCORE_BOARD.isCreated = false
		SCORE_BOARD.isActive = false
	end

end


--[[---------------------------------------------------------
	Name: gamemode:HUDDrawScoreBoard( )
	Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()
end
