surface.CreateFont("hud::base", {
    size = 22, 
    weight = 300, 
    antialias = true, 
    extended = true,
    italic = true,   
    font = "Roboto"
})

surface.CreateFont("hud::main", {
    size = 28, 
    weight = 350, 
    antialias = true, 
    extended = true,
    italic = true,
    font = "Roboto"
})
local function draw.AddText(text, font, x, y, color, xalign, yalign)
    draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 255), xalign, yalign)
    local x,y = draw.SimpleText(text, font, x, y, color, xalign, yalign)
    return x,y
end
local lerphp, lerparm = 0, 0
local function bar(x,y,var, valuelerp, color, colorhit)
    local bar = {
        { x = x+12, y = y+2 }, -- LT
        { x = x+8+200*var/100, y = y+2 }, -- RT
        { x = x+200*var/100, y = y+15 }, -- RB
        { x = x+4, y = y+15 }, -- LB
    }
    local barHit = {
        { x = x+12, y = y+2 }, -- LT
        { x = x+8+200*valuelerp/100, y = y+2 }, -- RT
        { x = x+200*valuelerp/100, y = y+15 }, -- RB
        { x = x+4, y = y+15 }, -- LB
    }

    surface.SetDrawColor(colorhit)
    surface.DrawPoly(barHit)

    surface.SetDrawColor(color)
    surface.DrawPoly(bar)

    draw.AddText(math.Round(valuelerp)..'%','hud::main',x+16,y+15/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
end
local function HudDraw()
    local hudpos = 0
    local hudposvar = 25
    local hudposcon = 110

	local frametime = RealFrameTime()

    local health =  math.Clamp(LocalPlayer():Health(),0,100) 
    local armor = math.Clamp(LocalPlayer():Armor(),0,100)

    lerphp = Lerp(frametime *2,lerphp,health)
    lerparm = Lerp(frametime *2,lerparm,armor)

    bar(80, ScrH()-50, LocalPlayer():Health(), lerphp, Color(255, 90, 90), Color(255, 120, 120))
    if LocalPlayer():Armor() > 0 then
        bar(90, ScrH()-75, LocalPlayer():Armor(), lerparm, Color(63, 143, 234), Color(90, 183, 249))
        hudpos = hudpos + hudposvar
    end

    local x1, y1 = draw.AddText(LocalPlayer():getDarkRPVar('job'),'hud::main', 45, ScrH()-70-hudpos,team.GetColor(LocalPlayer():Team()),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    local x2, y2 = draw.AddText('с лицензией','hud::main', 50+x1, ScrH()-70-hudpos,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    draw.AddText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar('salary')),'hud::main', 55+x1+x2, ScrH()-70-hudpos,Color(0,235,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    hudpos = hudpos + hudposvar
    draw.AddText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar('money')),'hud::main', 45, ScrH()-70-hudpos,Color(0,235,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    hudpos = hudpos + hudposvar
    if LocalPlayer():getDarkRPVar('wanted') then
        draw.AddText('Вы в розыске. Причина:'.. LocalPlayer():getDarkRPVar('wantedReason'),'hud::main', 45, ScrH()-70-hudpos,Color(250,250,250),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end
end

local hidden = { "DarkRP_LocalPlayerHUD","DarkRP_HUD", "DarkRP_Hungermod", "CHudHealth", "CHudAmmo", "DarkRP_Agenda","CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" }
hook.Add("HUDShouldDraw", "CHUD_Hide", function(name)
	if table.HasValue(hidden, name) || name == "CHudAmmo" && Config.ShowAmmoCircle then return false end
end)

hook.Add('HUDPaint', 'Neon::Hud', function()
    if ( LocalPlayer():Alive() ) then
        HudDraw()
    end
end)


