-- ==========================================================
-- SCRIPT: √12kientomato Hub Pro Max (Fixed UI Layout)
-- ==========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer

-- Ngôn ngữ mặc định
local currentLang = "vi"

local translations = {
    vi = {
        title = "√12kientomato Hub Pro Max",
        fixLagTitle = "--- HỆ THỐNG FIX LAG (1% - 100%) ---",
        fixLight = "⚡ Fix Lag Nhẹ (Cấp độ 1% - 30%)",
        fixMed = "⚡ Fix Lag Trung Bình (Cấp độ 31% - 70%)",
        fixMax = "⚡ Siêu Fix Lag Tối Đa (Cấp độ 100%)",
        restore = "🔄 Khôi Phục Trạng Thái Ban Đầu",
        utilityTitle = "--- TIỆN ÍCH GAMEPLAY ---",
        noclipOff = "👻 Bật/Tắt Noclip: ĐANG TẮT",
        noclipOn = "👻 Bật/Tắt Noclip: ĐANG BẬT",
        antiVoidOff = "🛡️ Chống Rơi Xuống Void: ĐANG TẮT",
        antiVoidOn = "🛡️ Chống Rơi Xuống Void: ĐANG BẬT",
        fastInteract = "⚡ Nhặt Vật Phẩm Nhanh",
        langBtn = "🌐 Ngôn ngữ: Tiếng Việt"
    },
    en = {
        title = "√12kientomato Hub Pro Max",
        fixLagTitle = "--- FIX LAG SYSTEM (1% - 100%) ---",
        fixLight = "⚡ Light Fix Lag (Level 1% - 30%)",
        fixMed = "⚡ Medium Fix Lag (Level 31% - 70%)",
        fixMax = "⚡ Max Fix Lag (Level 100%)",
        restore = "🔄 Restore Original State",
        utilityTitle = "--- GAMEPLAY UTILITIES ---",
        noclipOff = "👻 Toggle Noclip: OFF",
        noclipOn = "👻 Toggle Noclip: ON",
        antiVoidOff = "🛡️ Anti-Void Platform: OFF",
        antiVoidOn = "🛡️ Anti-Void Platform: ON",
        fastInteract = "⚡ Fast Collect",
        langBtn = "🌐 Language: English"
    }
}

-- Lưu trạng thái ban đầu để restore
local originalSettings = {
    Lighting = {
        GlobalShadows = Lighting.GlobalShadows,
        FogEnd = Lighting.FogEnd,
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime
    },
    Terrain = {
        WaterWaveSize = Workspace.Terrain.WaterWaveSize,
        WaterWaveSpeed = Workspace.Terrain.WaterWaveSpeed,
        WaterTransparency = Workspace.Terrain.WaterTransparency,
        WaterReflectance = Workspace.Terrain.WaterReflectance
    },
    Parts = {}
}

-- Xóa GUI cũ nếu đang chạy
if CoreGui:FindFirstChild("Sqrt12KienTomatoHub") then
    CoreGui.Sqrt12KienTomatoHub:Destroy()
end

-- Tạo ScreenGui chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Sqrt12KienTomatoHub"
screenGui.ResetOnSpawn = false
pcall(function()
    screenGui.Parent = CoreGui
end)
if screenGui.Parent ~= CoreGui then
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

-- ==================== GIAO DIỆN LOADING (ĐÃ FIX TỈ LỆ) ====================
local loadingGui = Instance.new("Frame")
loadingGui.Name = "LoadingGui"
loadingGui.Size = UDim2.new(0, 280, 0, 100)
loadingGui.Position = UDim2.new(0.5, -140, 0.5, -50)
loadingGui.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loadingGui.BorderSizePixel = 0
loadingGui.Parent = screenGui

local cornerLoad = Instance.new("UICorner")
cornerLoad.CornerRadius = UDim.new(0, 8)
cornerLoad.Parent = loadingGui

local loadTitle = Instance.new("TextLabel")
loadTitle.Size = UDim2.new(1, 0, 0, 30)
loadTitle.Position = UDim2.new(0, 0, 0, 5)
loadTitle.BackgroundTransparency = 1
loadTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
loadTitle.TextSize = 14
loadTitle.Font = Enum.Font.GothamBold
loadTitle.Text = "Đang tải √12kientomato Hub..."
loadTitle.Parent = loadingGui

local loadPercent = Instance.new("TextLabel")
loadPercent.Size = UDim2.new(1, 0, 0, 20)
loadPercent.Position = UDim2.new(0, 0, 0, 35)
loadPercent.BackgroundTransparency = 1
loadPercent.TextColor3 = Color3.fromRGB(200, 200, 200)
loadPercent.TextSize = 12
loadPercent.Font = Enum.Font.GothamSemibold
loadPercent.Text = "0%"
loadPercent.Parent = loadingGui

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -40, 0, 8)
barBg.Position = UDim2.new(0, 20, 0, 65)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barBg.BorderSizePixel = 0
barBg.Parent = loadingGui

local cornerBarBg = Instance.new("UICorner")
cornerBarBg.CornerRadius = UDim.new(1, 0)
cornerBarBg.Parent = barBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local cornerBarFill = Instance.new("UICorner")
cornerBarFill.CornerRadius = UDim.new(1, 0)
cornerBarFill.Parent = barFill

-- ==================== NÚT TOGGLE & MENU CHÍNH ====================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 20, 0, 100)
toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
toggleBtn.BorderSizePixel = 0
toggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
toggleBtn.TextSize = 20
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Text = "K"
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Visible = false
toggleBtn.Parent = screenGui

local cornerToggle = Instance.new("UICorner")
cornerToggle.CornerRadius = UDim.new(1, 0)
cornerToggle.Parent = toggleBtn

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 8)
cornerMain.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = translations[currentLang].title
titleLabel.Parent = mainFrame

local cornerTitle = Instance.new("UICorner")
cornerTitle.CornerRadius = UDim.new(0, 8)
cornerTitle.Parent = titleLabel

toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -10, 1, -50)
scrollingFrame.Position = UDim2.new(0, 5, 0, 45)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 720)
scrollingFrame.ScrollBarThickness = 4
scrollingFrame.Parent = mainFrame

local uiLayout = Instance.new("UIListLayout")
uiLayout.Padding = UDim.new(0, 8)
uiLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiLayout.Parent = scrollingFrame

local function createSectionTitle(textKey)
    local lbl = Instance.new("TextLabel")
    lbl.Name = "Section_" .. textKey
    lbl.Size = UDim2.new(1, -10, 0, 25)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = translations[currentLang][textKey] or textKey
    lbl.Parent = scrollingFrame
    return lbl
end

local function createButton(textKey, color, callback)
    local btn = Instance.new("TextButton")
    btn.Name = "Btn_" .. textKey
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = translations[currentLang][textKey] or textKey
    btn.Parent = scrollingFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ==================== CÁC CHỨC NĂNG ====================

createSectionTitle("fixLagTitle")

createButton("fixLight", Color3.fromRGB(60, 60, 90), function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Material ~= Enum.Material.SmoothPlastic then
            if not originalSettings.Parts[obj] then
                originalSettings.Parts[obj] = obj.Material
            end
            obj.Material = Enum.Material.SmoothPlastic
        end
    end
end)

createButton("fixMed", Color3.fromRGB(80, 70, 40), function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 2
    Workspace.Terrain.WaterWaveSize = 0
    Workspace.Terrain.WaterWaveSpeed = 0
    Workspace.Terrain.WaterTransparency = 0
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if not originalSettings.Parts[obj] then
                originalSettings.Parts[obj] = obj.Material
            end
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        end
    end
end)

createButton("fixMax", Color3.fromRGB(120, 40, 40), function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    Workspace.Terrain.WaterTransparency = 1
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if not originalSettings.Parts[obj] then
                originalSettings.Parts[obj] = obj.Material
            end
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        elseif obj:IsA("SpecialMesh") or obj:IsA("MeshPart") then
            obj.TextureID = ""
        end
    end
end)

createButton("restore", Color3.fromRGB(40, 100, 40), function()
    Lighting.GlobalShadows = originalSettings.Lighting.GlobalShadows
    Lighting.FogEnd = originalSettings.Lighting.FogEnd
    Lighting.Brightness = originalSettings.Lighting.Brightness
    Workspace.Terrain.WaterWaveSize = originalSettings.Terrain.WaterWaveSize
    Workspace.Terrain.WaterWaveSpeed = originalSettings.Terrain.WaterWaveSpeed
    Workspace.Terrain.WaterTransparency = originalSettings.Terrain.WaterTransparency
    
    for obj, mat in pairs(originalSettings.Parts) do
        if obj and obj.Parent then
            obj.Material = mat
            obj.CastShadow = true
        end
    end
end)

createSectionTitle("utilityTitle")

local noclipEnabled = false
local noclipBtn = createButton("noclipOff", Color3.fromRGB(50, 50, 50), function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = translations[currentLang][noclipEnabled and "noclipOn" or "noclipOff"]
    noclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 50, 50)
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and localPlayer.Character then
        for _, part in ipairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local antiVoidEnabled = false
local antiVoidPart = nil
local antiVoidBtn = createButton("antiVoidOff", Color3.fromRGB(50, 50, 50), function()
    antiVoidEnabled = not antiVoidEnabled
    antiVoidBtn.Text = translations[currentLang][antiVoidEnabled and "antiVoidOn" or "antiVoidOff"]
    antiVoidBtn.BackgroundColor3 = antiVoidEnabled and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 50, 50)
    
    if antiVoidEnabled then
        if not antiVoidPart then
            antiVoidPart = Instance.new("Part")
            antiVoidPart.Name = "AntiVoidPlatform"
            antiVoidPart.Size = Vector3.new(2000, 5, 2000)
            antiVoidPart.Position = Vector3.new(0, -50, 0)
            antiVoidPart.Anchored = true
            antiVoidPart.Transparency = 0.8
            antiVoidPart.Color = Color3.fromRGB(0, 255, 128)
            antiVoidPart.Parent = Workspace
        else
            antiVoidPart.Parent = Workspace
        end
    else
        if antiVoidPart then
            antiVoidPart.Parent = nil
        end
    end
end)

createButton("fastInteract", Color3.fromRGB(60, 100, 60), function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            obj.HoldDuration = 0
            obj.MaxActivationDistance = math.max(obj.MaxActivationDistance, 32)
        end
    end
    Workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("ProximityPrompt") then
            obj.HoldDuration = 0
            obj.MaxActivationDistance = math.max(obj.MaxActivationDistance, 32)
        end
    end)
end)

createButton("langBtn", Color3.fromRGB(70, 50, 90), function()
    if currentLang == "vi" then
        currentLang = "en"
    else
        currentLang = "vi"
    end
    
    titleLabel.Text = translations[currentLang].title
    for _, child in ipairs(scrollingFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            local key = child.Name:gsub("Section_", "")
            if translations[currentLang][key] then
                child.Text = translations[currentLang][key]
            end
        elseif child:IsA("TextButton") then
            local key = child.Name:gsub("Btn_", "")
            if key == "langBtn" then
                child.Text = translations[currentLang].langBtn
            elseif key == "noclipOff" or key == "noclipOn" then
                child.Text = translations[currentLang][noclipEnabled and "noclipOn" or "noclipOff"]
            elseif key == "antiVoidOff" or key == "antiVoidOn" then
                child.Text = translations[currentLang][antiVoidEnabled and "antiVoidOn" or "antiVoidOff"]
            elseif translations[currentLang][key] then
                child.Text = translations[currentLang][key]
            end
        end
    end
end)

-- ==================== CHẠY LOADING & HIỆN MENU ====================
task.spawn(function()
    for i = 1, 100 do
        loadPercent.Text = i .. "%"
        barFill.Size = UDim2.new(i / 100, 0, 1, 0)
        
        if i == 30 then
            loadTitle.Text = "Đang quét môi trường & hiệu ứng..."
        elseif i == 70 then
            loadTitle.Text = "Đang thiết lập giao diện chữ K..."
        elseif i == 95 then
            loadTitle.Text = "Hoàn tất hệ thống!"
        end
        
        task.wait(0.01)
    end
    
    task.wait(0.2)
    loadingGui:Destroy()
    
    -- Bật hiển thị nút logo K và Menu chính
    toggleBtn.Visible = true
    mainFrame.Visible = true
end)
