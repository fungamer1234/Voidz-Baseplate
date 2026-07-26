local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local COLORS = {
    bg = Color3.fromRGB(18, 18, 22),
    card = Color3.fromRGB(22, 22, 26),
    accent = Color3.fromRGB(255, 50, 50),
    accentDark = Color3.fromRGB(180, 35, 35),
    text = Color3.fromRGB(255, 255, 255),
    muted = Color3.fromRGB(150, 150, 150),
    subtle = Color3.fromRGB(40, 40, 45),
    cardHover = Color3.fromRGB(28, 28, 33),
    stroke = Color3.fromRGB(45, 45, 50),
    toggleOff = Color3.fromRGB(45, 45, 45),
    toggleOn = Color3.fromRGB(255, 50, 50),
    green = Color3.fromRGB(80, 255, 80),
    yellow = Color3.fromRGB(255, 255, 80),
    blue = Color3.fromRGB(80, 150, 255),
}

local gui = Instance.new("ScreenGui")
gui.Name = "VoidzBaseplate"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LP:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 540, 0, 400)
mainFrame.Position = UDim2.new(0.5, -270, 0.5, -200)
mainFrame.BackgroundColor3 = COLORS.bg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = COLORS.stroke; mainStroke.Thickness = 1.5

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleClip = Instance.new("Frame", titleBar)
titleClip.Size = UDim2.new(1, 0, 0, 20)
titleClip.Position = UDim2.new(0, 0, 1, -20)
titleClip.BackgroundTransparency = 1
titleClip.ClipsDescendants = true

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1, -160, 1, 0)
titleText.Position = UDim2.new(0, 14, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "THE VOIDZ — Fight on a Baseplate"
titleText.TextColor3 = COLORS.accent
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 13
titleText.TextXAlignment = Enum.TextXAlignment.Left

local statusLabel = Instance.new("TextLabel", titleBar)
statusLabel.Size = UDim2.new(0, 120, 1, 0)
statusLabel.Position = UDim2.new(0, 300, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "STATUS: LOADED"
statusLabel.TextColor3 = COLORS.green
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 10
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

local function makeTitleBtn(text, parent, xOff, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 28, 0, 28)
    btn.Position = UDim2.new(1, -32 * xOff, 0, 4)
    btn.BackgroundColor3 = color or Color3.fromRGB(80, 80, 85)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local minimizeBtn = makeTitleBtn("_", titleBar, 2, Color3.fromRGB(80, 80, 85))
local closeBtn = makeTitleBtn("X", titleBar, 1, Color3.fromRGB(200, 50, 50))

local minimizedFrame = Instance.new("TextButton", gui)
minimizedFrame.Size = UDim2.new(0, 80, 0, 80)
minimizedFrame.Position = UDim2.new(0.5, -40, 0.5, -40)
minimizedFrame.BackgroundColor3 = COLORS.bg
minimizedFrame.BorderSizePixel = 0
minimizedFrame.Text = "VOIDZ"
minimizedFrame.TextColor3 = COLORS.accent
minimizedFrame.Font = Enum.Font.GothamBold
minimizedFrame.TextSize = 12
minimizedFrame.Visible = false
minimizedFrame.Draggable = true
minimizedFrame.Active = true
Instance.new("UICorner", minimizedFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", minimizedFrame).Color = COLORS.stroke

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedFrame.Visible = true
end)
minimizedFrame.MouseButton1Click:Connect(function()
    minimizedFrame.Visible = false
    mainFrame.Visible = true
end)
closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, 0, 1, -36)
container.Position = UDim2.new(0, 0, 0, 36)
container.BackgroundTransparency = 1

local tabScroll = Instance.new("ScrollingFrame", container)
tabScroll.Size = UDim2.new(0, 105, 1, 0)
tabScroll.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
tabScroll.BorderSizePixel = 0
tabScroll.ScrollBarThickness = 2
tabScroll.ScrollBarImageColor3 = COLORS.subtle
tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", tabScroll).Padding = UDim.new(0, 3)

local contentFrame = Instance.new("Frame", container)
contentFrame.Size = UDim2.new(1, -105, 1, 0)
contentFrame.Position = UDim2.new(0, 105, 0, 0)
contentFrame.BackgroundColor3 = COLORS.bg
contentFrame.BorderSizePixel = 0

local contentScroll = Instance.new("ScrollingFrame", contentFrame)
contentScroll.Size = UDim2.new(1, -8, 1, -8)
contentScroll.Position = UDim2.new(0, 4, 0, 4)
contentScroll.BackgroundTransparency = 1
contentScroll.BorderSizePixel = 0
contentScroll.ScrollBarThickness = 3
contentScroll.ScrollBarImageColor3 = COLORS.accent
contentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
contentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local function corner(obj, r)
    Instance.new("UICorner", obj).CornerRadius = UDim.new(0, r or 6)
end

local function stroke(obj, color, thickness)
    local s = Instance.new("UIStroke", obj)
    s.Color = color or COLORS.stroke
    s.Thickness = thickness or 1
    return s
end

local function tw(obj, props, dur)
    TweenService:Create(obj, TweenInfo.new(dur or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local tabFrames = {}
local currentTab = nil

local function createTab(name, icon, order)
    local tabBtn = Instance.new("TextButton", tabScroll)
    tabBtn.Size = UDim2.new(1, -8, 0, 32)
    tabBtn.BackgroundColor3 = COLORS.card
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = ""
    tabBtn.LayoutOrder = order
    corner(tabBtn, 6)
    stroke(tabBtn, COLORS.stroke)

    local iconLbl = Instance.new("TextLabel", tabBtn)
    iconLbl.Size = UDim2.new(1, 0, 0, 14)
    iconLbl.Position = UDim2.new(0, 0, 0, 3)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icon
    iconLbl.TextColor3 = COLORS.accent
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.TextSize = 12

    local nameLbl = Instance.new("TextLabel", tabBtn)
    nameLbl.Size = UDim2.new(1, 0, 0, 12)
    nameLbl.Position = UDim2.new(0, 0, 0, 17)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = name
    nameLbl.TextColor3 = COLORS.muted
    nameLbl.Font = Enum.Font.Gotham
    nameLbl.TextSize = 8

    local frame = Instance.new("Frame", contentScroll)
    frame.Size = UDim2.new(1, 0, 0, 0)
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.BackgroundTransparency = 1
    frame.Visible = false
    Instance.new("UIListLayout", frame).Padding = UDim.new(0, 3)
    Instance.new("UIPadding", frame).PaddingTop = UDim.new(0, 2)

    tabFrames[name] = {btn = tabBtn, frame = frame, icon = iconLbl, nameLbl = nameLbl}

    tabBtn.MouseButton1Click:Connect(function()
        if currentTab and tabFrames[currentTab] then
            tabFrames[currentTab].frame.Visible = false
            tw(tabFrames[currentTab].btn, {BackgroundColor3 = COLORS.card}, 0.15)
            tw(tabFrames[currentTab].icon, {TextColor3 = COLORS.accent}, 0.15)
            tw(tabFrames[currentTab].nameLbl, {TextColor3 = COLORS.muted}, 0.15)
        end
        currentTab = name
        frame.Visible = true
        tw(tabBtn, {BackgroundColor3 = COLORS.accentDark}, 0.15)
        tw(iconLbl, {TextColor3 = COLORS.text}, 0.15)
        tw(nameLbl, {TextColor3 = COLORS.text}, 0.15)
    end)

    return frame
end

local function makeSection(parent, text, order)
    local s = Instance.new("Frame", parent)
    s.Size = UDim2.new(1, 0, 0, 26)
    s.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    s.BorderSizePixel = 0
    s.LayoutOrder = order or 0
    corner(s, 6)
    stroke(s, COLORS.stroke)
    local lbl = Instance.new("TextLabel", s)
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "▸ " .. text
    lbl.TextColor3 = COLORS.muted
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return s
end

local function makeToggle(parent, text, default, order, callback)
    local state = default or false
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 36)
    f.BackgroundColor3 = COLORS.card
    f.BorderSizePixel = 0
    f.LayoutOrder = order or 0
    corner(f, 6)
    stroke(f, COLORS.stroke)

    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = COLORS.text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local togBg = Instance.new("Frame", f)
    togBg.Size = UDim2.new(0, 38, 0, 20)
    togBg.Position = UDim2.new(1, -48, 0.5, -10)
    togBg.BackgroundColor3 = state and COLORS.toggleOn or COLORS.toggleOff
    togBg.BorderSizePixel = 0
    corner(togBg, 10)

    local circle = Instance.new("Frame", togBg)
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = COLORS.text
    circle.BorderSizePixel = 0
    corner(circle, 8)

    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""

    local function update()
        tw(togBg, {BackgroundColor3 = state and COLORS.toggleOn or COLORS.toggleOff}, 0.15)
        tw(circle, {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}, 0.15)
    end
    update()

    btn.MouseButton1Click:Connect(function()
        state = not state
        update()
        if callback then callback(state) end
    end)

    return {set = function(v) state = v; update() end, get = function() return state end}
end

local function makeButton(parent, text, order, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = COLORS.card
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.text
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.LayoutOrder = order or 0
    corner(btn, 6)
    stroke(btn, COLORS.stroke)

    btn.MouseEnter:Connect(function() tw(btn, {BackgroundColor3 = COLORS.cardHover}, 0.1) end)
    btn.MouseLeave:Connect(function() tw(btn, {BackgroundColor3 = COLORS.card}, 0.1) end)
    btn.MouseButton1Click:Connect(function()
        tw(btn, {Size = UDim2.new(1, 0, 0, 28)}, 0.05)
        task.delay(0.05, function() tw(btn, {Size = UDim2.new(1, 0, 0, 32)}, 0.05) end)
        if callback then callback() end
    end)
    return btn
end

local function makeSlider(parent, text, min, max, default, order, callback)
    local val = default
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 50)
    f.BackgroundTransparency = 1
    f.LayoutOrder = order or 0

    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. tostring(default)
    lbl.TextColor3 = COLORS.text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("TextButton", f)
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.new(0, 10, 0, 28)
    bar.BackgroundColor3 = COLORS.toggleOff
    bar.BorderSizePixel = 0
    bar.Text = ""
    bar.AutoButtonColor = false
    corner(bar, 3)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = COLORS.accent
    fill.BorderSizePixel = 0
    corner(fill, 3)

    local knob = Instance.new("TextButton", bar)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    knob.BackgroundColor3 = COLORS.text
    knob.BorderSizePixel = 0
    knob.Text = ""
    knob.AutoButtonColor = false
    corner(knob, 7)

    local dragging = false
    local function updateVal(newVal)
        val = math.clamp(newVal, min, max)
        local pct = (val - min) / (max - min)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        knob.Position = UDim2.new(pct, -7, 0.5, -7)
        lbl.Text = text .. ": " .. tostring(val)
        if callback then callback(val) end
    end

    local function onInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pct = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            updateVal(math.floor(min + (max - min) * pct))
        end
    end

    bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; onInput(input) end end)
    knob.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; onInput(input) end end)
    UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then onInput(input) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

    return {get = function() return val end, set = updateVal}
end

local function makeLabel(parent, text, order)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = COLORS.muted
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order or 0
    return lbl
end

-- ═══════════════════════════════════════════════════════════════
-- COMBAT ENGINE — VIM-based (mimics real clicks, bypasses anti-cheat)
-- ═══════════════════════════════════════════════════════════════
local state = {}
local connections = {}
local espObjects = {}
local stats = {kills = 0, hits = 0, deaths = 0, weaveCount = 0}

local cfg = {
    killAuraRange = 8,
    attackDelay = 0.18,
    weaveDelay = 0.4,
    speedMult = 3,
    hitboxSize = 10,
    espColor = COLORS.accent,
    reachDist = 20,
    floatHeight = 3,
    targetMode = "Closest",
    dashCooldown = 0.5,
    antiDetectDelay = 0.05,
}

local function getChar() return LP.Character end
local function getHRP() local c = getChar(); return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum() local c = getChar(); return c and c:FindFirstChildOfClass("Humanoid") end

local function getEnemies()
    local list = {}
    local hrp = getHRP()
    if not hrp then return list end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local tHRP = p.Character:FindFirstChild("HumanoidRootPart")
            local tHum = p.Character:FindFirstChildOfClass("Humanoid")
            if tHRP and tHum and tHum.Health > 0 then
                if not p.Character:FindFirstChildOfClass("ForceField") and not p.Character:FindFirstChild("Weave") then
                    local dist = (hrp.Position - tHRP.Position).Magnitude
                    if dist <= cfg.killAuraRange then
                        table.insert(list, {player = p, hrp = tHRP, hum = tHum, char = p.Character, dist = dist})
                    end
                end
            end
        end
    end
    table.sort(list, function(a, b)
        if cfg.targetMode == "Closest" then return a.dist < b.dist
        elseif cfg.targetMode == "Weakest" then return a.hum.Health < b.hum.Health
        elseif cfg.targetMode == "Strongest" then return a.hum.Health > b.hum.Health
        else return a.dist < b.dist end
    end)
    return list
end

local function faceTarget(target)
    local hrp = getHRP()
    if hrp and target and target.hrp then
        local look = (target.hrp.Position - hrp.Position).Unit
        hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(look.X, 0, look.Z))
    end
end

local function simulateClick()
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.03)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)
end

local function simulateKey(keycode)
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, keycode, false, game, 1)
        task.wait(0.03)
        VirtualInputManager:SendKeyEvent(false, keycode, false, game, 1)
    end)
end

local function startKillAura()
    if connections.killAura then return end
    connections.killAura = task.spawn(function()
        while state.killAura do
            local enemies = getEnemies()
            if #enemies > 0 then
                local target = enemies[1]
                if state.faceTarget then faceTarget(target) end

                simulateClick()
                stats.hits = stats.hits + 1

                local jitter = math.random(-2, 2) * 0.01
                task.wait(cfg.attackDelay + jitter)
            else
                task.wait(0.1)
            end
        end
    end)
end

local function stopKillAura()
    if connections.killAura then task.cancel(connections.killAura); connections.killAura = nil end
end

local function startAutoWeave()
    if connections.weave then return end
    connections.weave = task.spawn(function()
        while state.autoWeave do
            simulateKey(Enum.KeyCode.Q)
            stats.weaveCount = stats.weaveCount + 1
            local jitter = math.random(-5, 5) * 0.01
            task.wait(cfg.weaveDelay + jitter)
        end
    end)
end

local function stopAutoWeave()
    if connections.weave then task.cancel(connections.weave); connections.weave = nil end
end

local function startAutoBlock()
    if connections.block then return end
    connections.block = task.spawn(function()
        while state.autoBlock do
            simulateKey(Enum.KeyCode.F)
            local jitter = math.random(-3, 3) * 0.01
            task.wait(0.35 + jitter)
        end
    end)
end

local function stopAutoBlock()
    if connections.block then task.cancel(connections.block); connections.block = nil end
end

local function startAutoStomp()
    if connections.stomp then return end
    connections.stomp = task.spawn(function()
        while state.autoStomp do
            local enemies = getEnemies()
            for _, e in ipairs(enemies) do
                if e.hum.Health <= 0 or e.hrp.Position.Y < getHRP().Position.Y - 2 then
                    simulateKey(Enum.KeyCode.R)
                    task.wait(0.3)
                end
            end
            task.wait(0.2)
        end
    end)
end

local function stopAutoStomp()
    if connections.stomp then task.cancel(connections.stomp); connections.stomp = nil end
end

local function startAutoSlam()
    if connections.slam then return end
    connections.slam = task.spawn(function()
        while state.autoSlam do
            simulateKey(Enum.KeyCode.T)
            local jitter = math.random(-3, 3) * 0.01
            task.wait(1.5 + jitter)
        end
    end)
end

local function stopAutoSlam()
    if connections.slam then task.cancel(connections.slam); connections.slam = nil end
end

local function startAutoGrab()
    if connections.grab then return end
    connections.grab = task.spawn(function()
        while state.autoGrab do
            simulateKey(Enum.KeyCode.G)
            local jitter = math.random(-5, 5) * 0.01
            task.wait(1.0 + jitter)
        end
    end)
end

local function stopAutoGrab()
    if connections.grab then task.cancel(connections.grab); connections.grab = nil end
end

local function startAutoPush()
    if connections.push then return end
    connections.push = task.spawn(function()
        while state.autoPush do
            simulateKey(Enum.KeyCode.E)
            local jitter = math.random(-3, 3) * 0.01
            task.wait(1.2 + jitter)
        end
    end)
end

local function stopAutoPush()
    if connections.push then task.cancel(connections.push); connections.push = nil end
end

local function startAutoParry()
    if connections.parry then return end
    connections.parry = task.spawn(function()
        while state.autoParry do
            simulateKey(Enum.KeyCode.Q)
            stats.weaveCount = stats.weaveCount + 1
            task.wait(0.12 + math.random(-2, 2) * 0.01)
        end
    end)
end

local function stopAutoParry()
    if connections.parry then task.cancel(connections.parry); connections.parry = nil end
end

local function startNoCollide()
    if connections.noCollide then return end
    connections.noCollide = task.spawn(function()
        while state.noCollide do
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    for _, v in ipairs(p.Character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

local function stopNoCollide()
    if connections.noCollide then task.cancel(connections.noCollide); connections.noCollide = nil end
end

local function startSpeed()
    if connections.speed then return end
    connections.speed = RunService.Heartbeat:Connect(function(delta)
        if not state.speed then return end
        local hum = getHum()
        local char = getChar()
        if hum and char and hum.MoveDirection.Magnitude > 0 then
            char:TranslateBy(hum.MoveDirection * cfg.speedMult * delta * 10)
        end
    end)
end

local function stopSpeed()
    if connections.speed then connections.speed:Disconnect(); connections.speed = nil end
end

local function startBunnyHop()
    if connections.bunnyHop then return end
    connections.bunnyHop = task.spawn(function()
        while state.bunnyHop do
            local hum = getHum()
            if hum then hum.Jump = true end
            task.wait(0.12)
        end
    end)
end

local function stopBunnyHop()
    if connections.bunnyHop then task.cancel(connections.bunnyHop); connections.bunnyHop = nil end
end

local function startInfJump()
    if connections.infJump then return end
    connections.infJump = UserInputService.JumpRequest:Connect(function()
        if state.infJump then
            local hum = getHum()
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)
end

local function stopInfJump()
    if connections.infJump then connections.infJump:Disconnect(); connections.infJump = nil end
end

local function startAntiVoid()
    if connections.antiVoid then return end
    connections.antiVoid = RunService.Heartbeat:Connect(function()
        if not state.antiVoid then return end
        local hrp = getHRP()
        if hrp and hrp.Position.Y < -50 then
            hrp.CFrame = CFrame.new(0, 50, 0)
        end
    end)
end

local function stopAntiVoid()
    if connections.antiVoid then connections.antiVoid:Disconnect(); connections.antiVoid = nil end
end

local function startFloat()
    if connections.float then return end
    connections.float = RunService.Heartbeat:Connect(function()
        if not state.float then return end
        local hrp = getHRP()
        local hum = getHum()
        if hrp and hum and hrp.Position.Y < cfg.floatHeight then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function stopFloat()
    if connections.float then connections.float:Disconnect(); connections.float = nil end
end

local function startNoclip()
    if connections.noclip then return end
    connections.noclip = RunService.Stepped:Connect(function()
        if not state.noclip then return end
        local char = getChar()
        if char then
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end

local function stopNoclip()
    if connections.noclip then connections.noclip:Disconnect(); connections.noclip = nil end
end

local function startFly()
    if connections.fly then return end
    local bg, bv
    connections.fly = task.spawn(function()
        local hrp = getHRP()
        if not hrp then return end
        bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 9000; bg.D = 500
        bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.P = 9000

        while state.fly do
            local camCF = Camera.CFrame
            local dir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
            bv.Velocity = dir * 80
            bg.CFrame = camCF
            task.wait()
        end
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
    end)
end

local function stopFly()
    state.fly = false
    if connections.fly then task.cancel(connections.fly); connections.fly = nil end
end

local function startHitboxExpander()
    if connections.hitbox then return end
    connections.hitbox = task.spawn(function()
        while state.hitboxExpander do
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    for _, v in ipairs(p.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                            v.Size = Vector3.new(cfg.hitboxSize, cfg.hitboxSize, cfg.hitboxSize)
                            v.Transparency = 0.7
                            v.CanCollide = false
                            v.Material = Enum.Material.ForceField
                            v.BrickColor = BrickColor.new("Really red")
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

local function stopHitboxExpander()
    if connections.hitbox then task.cancel(connections.hitbox); connections.hitbox = nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, v in ipairs(p.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.Size = Vector3.new(2, 1, 1)
                    v.Transparency = 1
                    v.Material = Enum.Material.Plastic
                end
            end
        end
    end
end

local function startESP()
    if connections.esp then return end
    connections.esp = task.spawn(function()
        while state.esp do
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and not espObjects[p] then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.FillColor = cfg.espColor
                    hl.FillTransparency = 0.6
                    hl.OutlineColor = COLORS.text
                    hl.OutlineTransparency = 0
                    hl.Adornee = p.Character
                    hl.Name = "VoidzESP"
                    espObjects[p] = hl
                end
            end
            for p, hl in pairs(espObjects) do
                if not p.Character or not p.Parent or not state.esp then
                    if hl then hl:Destroy() end
                    espObjects[p] = nil
                end
            end
            task.wait(1)
        end
    end)
end

local function stopESP()
    if connections.esp then task.cancel(connections.esp); connections.esp = nil end
    for _, hl in pairs(espObjects) do if hl then hl:Destroy() end end
    espObjects = {}
end

local function startAutoFollow()
    if connections.follow then return end
    connections.follow = task.spawn(function()
        while state.autoFollow do
            local hum = getHum()
            if hum then
                local enemies = getEnemies()
                if #enemies > 0 then
                    hum:MoveTo(enemies[1].hrp.Position)
                end
            end
            task.wait(0.1)
        end
    end)
end

local function stopAutoFollow()
    if connections.follow then task.cancel(connections.follow); connections.follow = nil end
end

local function startSprintToTarget()
    if connections.sprint then return end
    connections.sprint = task.spawn(function()
        while state.sprintToTarget do
            local hrp = getHRP()
            local hum = getHum()
            if hrp and hum then
                local enemies = getEnemies()
                if #enemies > 0 then
                    local t = enemies[1]
                    local predicted = t.hrp.Position + (t.hrp.AssemblyLinearVelocity or Vector3.new()) * 0.1
                    local dir = (predicted - hrp.Position).Unit
                    local dist = (predicted - hrp.Position).Magnitude
                    hrp.CFrame = hrp.CFrame + dir * math.min(dist, 60) * 0.05
                    faceTarget(t)
                end
            end
            task.wait()
        end
    end)
end

local function stopSprintToTarget()
    if connections.sprint then task.cancel(connections.sprint); connections.sprint = nil end
end

local function startSpin()
    if connections.spin then return end
    connections.spin = task.spawn(function()
        while state.spin do
            local hrp = getHRP()
            if hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(15), 0) end
            task.wait()
        end
    end)
end

local function stopSpin()
    if connections.spin then task.cancel(connections.spin); connections.spin = nil end
end

local function startAntiAim()
    if connections.antiAim then return end
    connections.antiAim = task.spawn(function()
        while state.antiAim do
            local hrp = getHRP()
            if hrp then
                local angle = tick() * 5
                hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, angle, 0)
            end
            task.wait(0.05)
        end
    end)
end

local function stopAntiAim()
    if connections.antiAim then task.cancel(connections.antiAim); connections.antiAim = nil end
end

local function startAntiGrab()
    if connections.antiGrab then return end
    connections.antiGrab = task.spawn(function()
        while state.antiGrab do
            local char = getChar()
            if char then
                for _, v in ipairs(char:GetDescendants()) do
                    if v:IsA("BodyPosition") or v:IsA("BodyVelocity") or v:IsA("BodyAngularVelocity") or v:IsA("AlignPosition") or v:IsA("LinearVelocity") then
                        v:Destroy()
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end

local function stopAntiGrab()
    if connections.antiGrab then task.cancel(connections.antiGrab); connections.antiGrab = nil end
end

local function startReachExtender()
    if connections.reach then return end
    connections.reach = RunService.Heartbeat:Connect(function()
        if not state.reachExtender then return end
        local hrp = getHRP()
        if hrp then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local tHRP = p.Character:FindFirstChild("HumanoidRootPart")
                    if tHRP then
                        local dist = (hrp.Position - tHRP.Position).Magnitude
                        if dist > cfg.killAuraRange and dist < cfg.reachDist then
                            hrp.CFrame = tHRP.CFrame
                            task.wait(0.05)
                            hrp.CFrame = hrp.CFrame
                        end
                    end
                end
            end
        end
    end)
end

local function stopReachExtender()
    if connections.reach then task.cancel(connections.reach); connections.reach = nil end
end

local function startAntiKick()
    pcall(function()
        LP.CharacterAdded:Connect(function(char)
            if state.antiKick then
                task.wait(0.5)
                local hum = char:WaitForChild("Humanoid", 5)
                if hum then hum.Died:Connect(function() stats.deaths = stats.deaths + 1 end) end
            end
        end)
    end)
end

local function startInfZoom()
    pcall(function()
        LP.CameraMaxZoomDistance = 99999
        LP.CameraMinZoomDistance = 0.5
    end)
end

local function startCameraShake()
    pcall(function()
        for _, v in pairs(getgc()) do
            if type(v) == "function" and debug.info(v, "n") == "Play" and debug.info(v, "s"):match("CameraShake") then
                hookfunction(v, function() return end)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- BUILD TABS
-- ═══════════════════════════════════════════════════════════════

local combatTab = createTab("Combat", "⚔", 1)
makeSection(combatTab, "Kill Aura (Clicks)", 1)
makeSlider(combatTab, "Range", 3, 25, 8, 2, function(v) cfg.killAuraRange = v end)
makeSlider(combatTab, "Attack Delay (ms)", 10, 50, 18, 3, function(v) cfg.attackDelay = v / 100 end)
makeToggle(combatTab, "Kill Aura", false, 5, function(v)
    state.killAura = v
    if v then startKillAura() else stopKillAura() end
    statusLabel.Text = v and "STATUS: COMBAT ON" or "STATUS: LOADED"
    statusLabel.TextColor3 = v and COLORS.green or COLORS.muted
end)
makeToggle(combatTab, "Face Target", false, 6, function(v) state.faceTarget = v end)

makeSection(combatTab, "Auto Actions (Keys)", 10)
makeToggle(combatTab, "Auto Weave (Q)", false, 11, function(v)
    state.autoWeave = v
    if v then startAutoWeave() else stopAutoWeave() end
end)
makeSlider(combatTab, "Weave Delay (ms)", 20, 100, 40, 12, function(v) cfg.weaveDelay = v / 100 end)
makeToggle(combatTab, "Auto Parry (Fast Q)", false, 13, function(v)
    state.autoParry = v
    if v then startAutoParry() else stopAutoParry() end
end)
makeToggle(combatTab, "Auto Block (F)", false, 14, function(v)
    state.autoBlock = v
    if v then startAutoBlock() else stopAutoBlock() end
end)
makeToggle(combatTab, "Auto Stomp (R)", false, 15, function(v)
    state.autoStomp = v
    if v then startAutoStomp() else stopAutoStomp() end
end)
makeToggle(combatTab, "Auto Slam (T)", false, 16, function(v)
    state.autoSlam = v
    if v then startAutoSlam() else stopAutoSlam() end
end)
makeToggle(combatTab, "Auto Grab (G)", false, 17, function(v)
    state.autoGrab = v
    if v then startAutoGrab() else stopAutoGrab() end
end)
makeToggle(combatTab, "Auto Push (E)", false, 18, function(v)
    state.autoPush = v
    if v then startAutoPush() else stopAutoPush() end
end)

makeSection(combatTab, "Defense", 20)
makeToggle(combatTab, "No-Collide Defense", false, 21, function(v)
    state.noCollide = v
    if v then startNoCollide() else stopNoCollide() end
end)
makeToggle(combatTab, "Anti-Grab", false, 22, function(v)
    state.antiGrab = v
    if v then startAntiGrab() else stopAntiGrab() end
end)
makeToggle(combatTab, "Anti-Aim", false, 23, function(v)
    state.antiAim = v
    if v then startAntiAim() else stopAntiAim() end
end)
makeToggle(combatTab, "Remove Camera Shake", false, 24, function(v) if v then startCameraShake() end end)

makeSection(combatTab, "Targeting", 30)
makeToggle(combatTab, "Reach Extender", false, 31, function(v)
    state.reachExtender = v
    if v then startReachExtender() else stopReachExtender() end
end)
makeSlider(combatTab, "Reach Distance", 10, 60, 20, 32, function(v) cfg.reachDist = v end)
makeToggle(combatTab, "Sprint To Target", false, 33, function(v)
    state.sprintToTarget = v
    if v then startSprintToTarget() else stopSprintToTarget() end
end)
makeToggle(combatTab, "Auto Follow", false, 34, function(v)
    state.autoFollow = v
    if v then startAutoFollow() else stopAutoFollow() end
end)

local hitboxTab = createTab("Hitbox", "🎯", 2)
makeSection(hitboxTab, "Hitbox Expander", 1)
makeToggle(hitboxTab, "Enable Hitbox Expander", false, 2, function(v)
    state.hitboxExpander = v
    if v then startHitboxExpander() else stopHitboxExpander() end
end)
makeSlider(hitboxTab, "Hitbox Size", 5, 60, 10, 3, function(v) cfg.hitboxSize = v end)

local moveTab = createTab("Move", "🏃", 3)
makeSection(moveTab, "Speed", 1)
makeToggle(moveTab, "Speed Boost", false, 2, function(v)
    state.speed = v
    if v then startSpeed() else stopSpeed() end
end)
makeSlider(moveTab, "Speed Multiplier", 1, 15, 3, 3, function(v) cfg.speedMult = v end)

makeSection(moveTab, "Jump & Fly", 10)
makeToggle(moveTab, "Bunny Hop", false, 11, function(v)
    state.bunnyHop = v
    if v then startBunnyHop() else stopBunnyHop() end
end)
makeToggle(moveTab, "Infinite Jump", false, 12, function(v)
    state.infJump = v
    if v then startInfJump() else stopInfJump() end
end)
makeToggle(moveTab, "Fly (WASD + Space/Ctrl)", false, 13, function(v)
    state.fly = v
    if v then startFly() else stopFly() end
end)
makeToggle(moveTab, "Noclip", false, 14, function(v)
    state.noclip = v
    if v then startNoclip() else stopNoclip() end
end)

makeSection(moveTab, "Special", 20)
makeToggle(moveTab, "Float", false, 21, function(v)
    state.float = v
    if v then startFloat() else stopFloat() end
end)
makeSlider(moveTab, "Float Height", 1, 25, 3, 22, function(v) cfg.floatHeight = v end)
makeToggle(moveTab, "Anti-Void", false, 23, function(v)
    state.antiVoid = v
    if v then startAntiVoid() else stopAntiVoid() end
end)
makeToggle(moveTab, "Spin", false, 24, function(v)
    state.spin = v
    if v then startSpin() else stopSpin() end
end)

local visualTab = createTab("Visual", "👁", 4)
makeSection(visualTab, "ESP", 1)
makeToggle(visualTab, "Player ESP", false, 2, function(v)
    state.esp = v
    if v then startESP() else stopESP() end
end)

makeSection(visualTab, "Camera", 10)
makeToggle(visualTab, "Infinite Zoom", false, 11, function(v) if v then startInfZoom() end end)
makeButton(visualTab, "Reset Camera", 12, function()
    Camera.CameraType = Enum.CameraType.Custom
end)
makeButton(visualTab, "FPS Boost", 13, function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Explosion") then v:Destroy() end
    end
end)

local playerTab = createTab("Player", "👤", 5)
makeSection(playerTab, "Character", 1)
makeButton(playerTab, "Reset Character", 2, function()
    local c = getChar()
    if c then c:BreakJoints() end
end)
makeButton(playerTab, "Teleport to Cursor", 3, function()
    local hrp = getHRP()
    if hrp then hrp.CFrame = LP:GetMouse().CFrame + Vector3.new(0, 3, 0) end
end)
makeButton(playerTab, "Teleport to Nearest", 4, function()
    local hrp = getHRP()
    if hrp then
        local closest, closestDist = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local tHRP = p.Character:FindFirstChild("HumanoidRootPart")
                if tHRP then
                    local d = (hrp.Position - tHRP.Position).Magnitude
                    if d < closestDist then closestDist = d; closest = tHRP end
                end
            end
        end
        if closest then hrp.CFrame = closest.CFrame + Vector3.new(0, 3, 0) end
    end
end)

local serverTab = createTab("Server", "🌐", 6)
makeSection(serverTab, "Info", 1)
makeLabel(serverTab, "Players: " .. #Players:GetPlayers() .. " / " .. Players.MaxPlayers, 2)
makeButton(serverTab, "Rejoin Server", 3, function()
    LP:Kick("Rejoining...")
    task.wait(0.5)
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)
makeButton(serverTab, "Server Hop", 4, function()
    pcall(function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in ipairs(servers.data or {}) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, LP)
                break
            end
        end
    end)
end)

local statsTab = createTab("Stats", "📊", 7)
makeSection(statsTab, "Combat Stats", 1)
local hitsLabel = makeLabel(statsTab, "Hits: 0", 2)
local weaveLabel = makeLabel(statsTab, "Weaves: 0", 3)
local deathLabel = makeLabel(statsTab, "Deaths: 0", 4)
task.spawn(function()
    while gui.Parent do
        hitsLabel.Text = "Hits: " .. stats.hits
        weaveLabel.Text = "Weaves: " .. stats.weaveCount
        deathLabel.Text = "Deaths: " .. stats.deaths
        task.wait(0.5)
    end
end)

local settingsTab = createTab("Settings", "⚙", 8)
makeSection(settingsTab, "Panic", 1)
makeButton(settingsTab, "STOP EVERYTHING", 2, function()
    for k, _ in pairs(state) do state[k] = false end
    stopKillAura(); stopAutoWeave(); stopAutoParry(); stopNoCollide()
    stopSpeed(); stopBunnyHop(); stopInfJump(); stopAntiVoid()
    stopFloat(); stopNoclip(); stopFly(); stopHitboxExpander()
    stopESP(); stopAutoFollow(); stopSprintToTarget(); stopSpin()
    stopAntiAim(); stopAntiGrab(); stopAutoBlock(); stopAutoStomp()
    stopAutoSlam(); stopAutoGrab(); stopAutoPush(); stopReachExtender()
    statusLabel.Text = "STATUS: STOPPED"
    statusLabel.TextColor3 = COLORS.yellow
end)
makeButton(settingsTab, "Unload Script", 3, function()
    for k, _ in pairs(state) do state[k] = false end
    stopKillAura(); stopAutoWeave(); stopAutoParry(); stopNoCollide()
    stopSpeed(); stopBunnyHop(); stopInfJump(); stopAntiVoid()
    stopFloat(); stopNoclip(); stopFly(); stopHitboxExpander()
    stopESP(); stopAutoFollow(); stopSprintToTarget(); stopSpin()
    stopAntiAim(); stopAntiGrab(); stopAutoBlock(); stopAutoStomp()
    stopAutoSlam(); stopAutoGrab(); stopAutoPush(); stopReachExtender()
    gui:Destroy()
end)

-- ═══════════════════════════════════════════════════════════════
-- KEYBINDS
-- ═══════════════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
        if not mainFrame.Visible then minimizedFrame.Visible = false end
    end
end)

local firstTab = tabFrames["Combat"]
if firstTab then
    firstTab.frame.Visible = true
    tw(firstTab.btn, {BackgroundColor3 = COLORS.accentDark}, 0.15)
    tw(firstTab.icon, {TextColor3 = COLORS.text}, 0.15)
    tw(firstTab.nameLbl, {TextColor3 = COLORS.text}, 0.15)
    currentTab = "Combat"
end

statusLabel.Text = "STATUS: LOADED"
statusLabel.TextColor3 = COLORS.green
startAntiKick()
