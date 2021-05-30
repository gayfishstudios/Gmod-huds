
--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

surface.CreateFont( "hud.percs", {
	font = "Electrolize [RUS by Daymarius]",
	size = 18,
	weight = 500,
	extended = true,
})

surface.CreateFont("hud_base", {
    size = 22, 
    weight = 300, 
    antialias = true, 
    extended = true, 
    font = "Hermes"
})

surface.CreateFont("hud_lvl", {
    size = 25, 
    weight = 600, 
    antialias = true, 
    extended = true, 
    font = "Roboto"
})

surface.CreateFont("hud_exp", {
    size = 16, 
    weight = 300, 
    antialias = true, 
    extended = true, 
    font = "Roboto"
})

surface.CreateFont("hud_ammo", {
    size = 30, 
    weight = 600, 
    antialias = true, 
    extended = true, 
    italic = true, 
    font = "Roboto"
})

surface.CreateFont("hud_stat", {
	size = 25, 
	weight = 300, 
	antialias = true, 
	extended = true, 
	italic = true, 
	font = "Roboto"
})
surface.CreateFont("hud_stat_shadow", {
	size = 25, 
	weight = 300, 
	antialias = true, 
	blursize = 3, 
	additive = false, 
	italic = true, 
	extended = true, 
	font = "Roboto"
})


--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

local elements = {
	{ x = -450, letter = "", color = Color(29,161,242) },
	{ x = -360, letter = "n", color = Color(29,161,242) },
	{ x = -315, letter = "ne", color = Color(29,161,242) },
	{ x = -270, letter = "e", color = Color(29,161,242) },
	{ x = -225, letter = "se", color = Color(29,161,242) },
	{ x = -180, letter = "s", color = Color(29,161,242) },
	{ x = -135, letter = "sw", color = Color(29,161,242) },
	{ x = -90, letter = "w", color = Color(29,161,242) },
	{ x = -45, letter = "nw", color = Color(29,161,242) },

	{ x = 0, letter = "n", color = Color(234, 32, 39) },

	{ x = 45, letter = "ne", color = Color(29,161,242) },
	{ x = 90, letter = "e", color = Color(29,161,242) },
	{ x = 135, letter = "se", color = Color(29,161,242) },
	{ x = 180, letter = "s", color = Color(29,161,242) },
	{ x = 225, letter = "sw", color = Color(29,161,242) },
	{ x = 270, letter = "w", color = Color(29,161,242) },
	{ x = 315, letter = "nw", color = Color(29,161,242) },
	{ x = 360, letter = "n", color = Color(29,161,242) },
	{ x = 450, letter = "w", color = Color(29,161,242) },

	{ x = 15 },
	{ x = 30 },
	{ x = 60 },
	{ x = 75 },
	{ x = 105 },
	{ x = 120 },
	{ x = 150 },
	{ x = 165 },
	{ x = 195 },
	{ x = 210 },
	{ x = 240 },
	{ x = 255 },
	{ x = 285 },
	{ x = 300 },
	{ x = 330 },
	{ x = 345 },

	{ x = -15 },
	{ x = -30 },
	{ x = -60 },
	{ x = -75 },
	{ x = -105 },
	{ x = -120 },
	{ x = -150 },
	{ x = -165 },
	{ x = -195 },
	{ x = -210 },
	{ x = -240 },
	{ x = -255 },
	{ x = -285 },
	{ x = -300 },
	{ x = -330 },
	{ x = -345 },
}

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

local scale = math.Clamp(ScrH() / 1080, 0.6, 1)
local t = { cfg = {}, clr = {}, wep = {}, icon = {} }

t['W'] = ScrW()
t['H'] = ScrH()

t['cfg']['vec13'] = Vector(0, 0, 13)

t['clr']['ot']	= Color(240,196,11)
t['clr']['hp'] 	= Color(118,51,51)
t['clr']['ar']	= Color(51,76,118)
t['clr']['bg']	= Color(41,49,60)

t['wep']['weapon_lightsaber_personal'] = true
t['wep']['weapon_lightsaber_personal_dual'] = true

t['icon']['chat'] = Material("jvs/hud/chat.png", "smooth mips")
t['icon']['voice'] = Material("jvs/hud/mic.png", "smooth mips")

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

local function box(x, y, w, h, c)
	surface.SetDrawColor( c.r, c.g, c.b, c.a )
	surface.DrawRect( x, y, w, h )
	return x+w, y+h
end

local function AddText(text, font, x, y, color, xalign, yalign)
    draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 220), xalign, yalign)
    local x, y = draw.SimpleText(text, font, x, y, color, xalign, yalign)
    return x, y
end

local function putText(text, font, x, y, color, xalign, yalign)
    draw.SimpleText(text, font .. "_shadow", x, y, color_black, xalign, yalign)
    draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 230), xalign, yalign)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function putIcon(color, material, xalign, yalign, x, y)
    surface.SetDrawColor(color_black)
    surface.SetMaterial(material)
    surface.DrawTexturedRect(xalign, yalign, x, y)

    surface.SetDrawColor(Color(0, 0, 0, 230))
    surface.SetMaterial(material)
    surface.DrawTexturedRect(xalign, yalign, x + 1, y + 1)

    surface.SetDrawColor(color)
    surface.SetMaterial(material)
    surface.DrawTexturedRect(xalign, yalign, x, y)            
end

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

local function Admin()

    local admine = 0
    local adminvar = -25
    local admincon = 25

    -- AddText('AdminMode', 'hud_base', 20, admincon + admine, Color(241, 196, 15), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    -- admine = admine - adminvar

    if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and not LocalPlayer():InVehicle() then
        AddText('Fly', 'hud_base', 20,admincon + admine, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        admine = admine - adminvar
    end

    -- if LocalPlayer():GetNWBool("ulx_godded") then
        -- AddText('GodMode', 'hud_base', 20,admincon + admine, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        -- admine = admine - adminvar
    -- end

    if LocalPlayer():GetNVar('observer') then
        AddText('Cloack', 'hud_base', 20,admincon + admine, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	admine = admine - adminvar
    end
end

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

local health_Lerp = 100
local armor_Lerp = 0
local enargy_Lerp = 100
local stamina_Lerp = 100

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

function GAMEMODE:HUDPaint()
    local lp = LocalPlayer()
	if lp:Team() == 1 then 
		return 
	elseif !IsValid(lp) then 
		return 
	elseif !lp:Alive() then 
		return 
	end

	local swep = lp:GetActiveWeapon()
	local level = lp:GetNW2Int( "wOS.SkillLevel", 0 )
	local xp = lp:GetNW2Int( "wOS.SkillExperience", 0 )
	local reqxp = wOS.XPScaleFormula( level )
	local lastxp = 0

	if level > 0 then
		lastxp = wOS.XPScaleFormula( level - 1 )
	end
	local rat = ( xp - lastxp )/( reqxp - lastxp )
	if level == wOS.SkillMaxLevel then
		rat = 1
	end

	local health = lp:Health() or 0
	local health_Maximum = lp:GetMaxHealth() or 0

	local armor = lp:Armor() or 0
	local armor_Maximum = 100

	health_Lerp = Lerp(FrameTime()*3, health_Lerp, math.Clamp(health, 0, health_Maximum))
	armor_Lerp = Lerp(FrameTime()*3, armor_Lerp, math.Clamp(armor, 0, armor_Maximum))
	
	local width = t['W']*0.26;
	
	local x = box(11,t['H']-93,5,68, t['clr']['ot'])
	local xbg = box(x,t['H']-93,width,68, t['clr']['bg'])
	
	-- ARMOR
	AddText("ar", "hud_base", x+25, t['H']-73, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	AddText(math.Round(armor_Lerp) , "hud_base", x+65, t['H']-73, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	box(x+100,t['H']-25-50,width-110,8, color_white)
	box(x+100,t['H']-25-52,(width-110)/armor_Maximum * armor_Lerp,12, t['clr']['ar'])
	
	-- HEALTH
	AddText("hp", "hud_base", x+25, t['H']-51, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	AddText(math.Round(health_Lerp) , "hud_base", x+65, t['H']-51, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	box(x+100,t['H']-25-28,width-110,8, color_white)
	box(x+100,t['H']-25-30,(width-110)/health_Maximum * health_Lerp,12, t['clr']['hp'])

	box(t['W']-120,25,100,40, t['clr']['bg'])
	box(t['W']-120,21,100*rat,4, t['clr']['ot'])
	AddText("Ур." .. level, "hud_lvl", t['W']-70,45, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	AddText(math.floor(rat*100), "hud_exp", t['W']-70,13, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	if t['wep'][swep:GetClass()] then

		local stamina = lp:GetStamina() or 0
		local stamina_Maximum = 100

		local enegry = swep:GetForce() or 0
		local enegry_Maximum = 100

		stamina_Lerp = Lerp(FrameTime()*3, stamina_Lerp, math.Clamp(stamina, 0, stamina_Maximum))
		enargy_Lerp = Lerp(FrameTime()*3, enargy_Lerp, math.Clamp(enegry, 0, enegry_Maximum))
		
		local xs = box(11,t['H']-93-50,5,50, t['clr']['ot'])
		box(xs+4,t['H']-93-42,5,34, t['clr']['bg'])
		AddText("Способность: " .. swep:GetActiveForcePowerType( swep:GetForceType())['name'], "hud_ammo", x+15, t['H']-93-25, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

		local xsta = box(xbg+10,t['H']-93,52,68, ColorAlpha(t['clr']['bg'], 195))
		box(xsta,t['H']-25-68/stamina_Maximum * stamina_Lerp,5,68/stamina_Maximum * stamina_Lerp, ColorAlpha(t['clr']['ot'], 195))
		-- AddText("STAMINA", "hud_base", xbg+10+26,t['H']-93+34, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		AddText(math.Round(lp:GetStamina()) , "hud_base", xbg+10+26,t['H']-93+46, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		local xerg = box(xsta+15,t['H']-93,52,68, ColorAlpha(t['clr']['bg'], 195) )
		box(xerg,t['H']-25-68/enegry_Maximum * enargy_Lerp,5,68/enegry_Maximum * enargy_Lerp, ColorAlpha(t['clr']['ot'], 195))
		-- AddText("ENARGY", "hud_base", xsta+10+26,t['H']-93+34, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		AddText(math.Round(swep:GetForce()) , "hud_base", xsta+15+26,t['H']-93+46, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end

	Admin()
	 
	do
		local offLimit = ScrW() / 6
		local offset = LocalPlayer():GetAngles().y
		for i, el in ipairs(elements) do
			local x = (el.x + offset) * 4
			if x < -offLimit then continue end
			if x > offLimit then continue end

			local alpha = (offLimit - math.abs(x)) / offLimit * 255
			local draw_x = ScrW() / 2 + x

			surface.SetDrawColor(Color(255,255,255,alpha))
			local color = el.color and Color(el.color.r,el.color.g,el.color.b,alpha*6) or Color(255,255,255,alpha)
			if el.letter then
				surface.DrawLine(draw_x-2, 5, draw_x-2, 15)
				AddText( el.letter, "hud_base", draw_x-2, 15, color, 1, 0, 1, Color(0,0,0,alpha/2))
			else
				surface.DrawLine(draw_x-1, 5, draw_x-1, 13)

				local x_ = el.x > 0 and el.x or 360 + el.x
				AddText( x_, "hud_base", draw_x, 15, color, 1, 0, 1, Color(0,0,0,alpha/2))
			end
		end
		AddText("▼", "hud.percs", ScrW()/2, -4, color_white, 1, 0);
	end

end

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

local function JVSNames(ply, pos)
	local lp = LocalPlayer()
	if (ply == lp) then return end
	if !IsValid(lp) then return end
	if !IsValid(ply) then return end

	local name = ply:Name() or 'UNKNOWN'
	local job = ply:Team() or 0

    local Bone = ply:LookupBone("ValveBiped.Bip01_Head1")
    if not Bone then return end

    local BonePos, _ = ply:GetBonePosition(Bone)
    if not BonePos then return end

    pos = BonePos + t['cfg']['vec13']

    pos = pos:ToScreen()
    pos.y = pos.y - 30	
    
    putText(name, "hud_stat", pos.x, pos.y + 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	putText(team.GetName(job), "hud_stat", pos.x, pos.y + 45, team.GetColor(job), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    if ply:IsSpeaking() and !ply:IsTyping() then
    	putIcon(HSVToColor(190, math.abs(math.sin(RealTime() * 2)), 1), t['icon']['voice'], pos.x - 15, pos.y - 40, 35, 35)
    end
    
	if !ply:IsSpeaking() and ply:IsTyping() then
    	putIcon(HSVToColor(190, math.abs(math.sin(RealTime() * 2)), 1), t['icon']['chat'], pos.x - 15, pos.y - 40, 35, 35)
    end
    
    if ply:IsSpeaking() and ply:IsTyping() then
    	putIcon(HSVToColor(190, math.abs(math.sin(RealTime() * 2)), 1), t['icon']['voice'], pos.x - 35, pos.y - 40, 35, 35)
    	putIcon(HSVToColor(190, math.abs(math.sin(RealTime() * 2)), 1), t['icon']['chat'], pos.x + 5, pos.y - 40, 35, 35)
    end
end

hook.Add("HUDPaint", "JVSNames", function()
	if !LocalPlayer():Alive() then return end
    
    for k, ply in ipairs(player.GetAll()) do
        local pos = ply:EyePos()

        if not (ply == LocalPlayer()) then
            if ply:Alive() then
				if ply:GetPos():Distance(LocalPlayer():GetPos()) < 250 then
					JVSNames(ply, ply:EyePos())
				end
            end
        end
    end 
end)

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

function GAMEMODE:HUDDrawTargetID()
	return false
end

function GAMEMODE:DrawDeathNotice()
	return false
end

hook.Add('Think', 'LowHP_DSP', function()
	if LocalPlayer():Health() < 25 then
		LocalPlayer():SetDSP(3)
	else
		LocalPlayer():SetDSP(0)
	end;
end);


--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--

-- local hidden = {
-- 	["DarkRP_Agenda"] = true, 
-- 	["DarkRP_LockdownHUD"] = true, 
-- 	["DarkRP_ArrestedHUD"] = true, 
-- 	["DarkRP_Hungermod"] = true, 
-- 	-- ["CHudWeaponSelection"] = true,
-- 	["CHudHealth"] = true, 
-- 	["CHudBattery"] = true, 
-- 	["CHudAmmo"] = true, 
-- 	["CHudSecondaryAmmo"] = true,
-- }

-- local function HideDarkRPHUD(name)
--     if hidden[name] then
--         return false
--     else 
--         return true
--     end
-- end

-- hook.Add("HUDShouldDraw", "CHudWeaponSelectionHide", HideDarkRPHUD)

--[[---------------------------------------------------------------------------

---------------------------------------------------------------------------]]--
