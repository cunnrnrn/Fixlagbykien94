-- ==========================================================
-- SCRIPT: √12kientomato Hub Pro Max (Final Fixed Version)
-- ==========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer
local currentLang = "vi"

local translations = {
    vi = {
        title = "√12kientomato Hub Pro Max",
        tabFixLag = "⚡ Fix Lag",
        tabUtils = "🛠️ Tiện Ích",
        fixLight = "🔹 Fix Lag Nhẹ (30%)",
        fixMed = "🔸 Fix Lag Vừa (70%)",
        fixMax = "🚀 Siêu Fix Lag Tối Đa (100%)",
        restore = "🔄 Khôi Phục Gốc",
        noclipOff = "👻 Noclip: OFF",
        noclipOn = "👻 Noclip: ON",
        antiVoidOff = "🛡️ Chống Void: OFF",
        antiVoidOn = "🛡️ Chống Void: ON",
        fastInteract = "⚡ Nhặt Nhanh (0s)",
        langBtn = "🌐 Ngôn ngữ: Tiếng Việt"
    },
    en = {
        title = "√12kientomato Hub Pro Max",
        tabFixLag = "⚡ Fix Lag",
        tabUtils = "🛠️ Utilities",
        fixLight = "🔹 Light Fix (30%)",
        fixMed = "🔸 Medium Fix (70%)",
        fixMax = "🚀 Max Fix (100%)",
        restore = "🔄 Restore Original",
        noclipOff = "👻 Noclip: OFF",
        noclipOn = "👻 Noclip: ON",
        antiVoidOff = "🛡️ Anti-Void: OFF",
        antiVoidOn = "🛡️ Anti-Void: ON",
        fastInteract = "⚡ Fast Collect",
        langBtn = "🌐 Language: English"
    }
}

-- Lưu trạng thái gốc để restore
local originalSettings = {
    Lighting = {
        GlobalShadows = Lighting.GlobalShadows,
        FogEnd = Lighting.FogEnd,
        Brightness = Lighting.Brightness
    },
    Terrain = {
        WaterTransparency = Workspace.Terrain.WaterTransparency
    },
    Parts = {}
}

-- Xóa GUI cũ
if CoreGui:FindFirstChild("Sqrt12KienTomatoHub") then
    CoreGui.Sqrt12KienTomatoHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Sqrt12KienTomatoHub"
screenGui.ResetOnSpawn = false
pcall(function() screenGui.Parent = CoreGui end)
if screenGui.Parent ~= CoreGui then
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

-- Nút Toggle Chữ K
local toggleBtn = Instance.new("TextButton")
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
toggleBtn.Parent = screenGui

local cornerToggle = Instance.new("UICorner")
cornerToggle.CornerRadius = UDim.new(1, 0)
cornerToggle.Parent = toggleBtn

-- Menu Chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 8)
cornerMain.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = translations[currentLang].title
titleLabel.Parent = mainFrame

local cornerTitle = Instance.new("UICorner")
cornerTitle.CornerRadius = UDim.new(0, 8)
cornerTitle.Parent = titleLabel

toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- ==================== HỆ THỐNG TAB ====================
local tabHeaderFrame = Instance.new("Frame")
tabHeaderFrame.Size = UDim2.new(1, -10, 0, 30)
tabHeaderFrame.Position = UDim2.new(0, 5, 0, 40)
tabHeaderFrame.BackgroundTransparency = 1
tabHeaderFrame.Parent = mainFrame

local tabFixBtn = Instance.new("TextButton")
tabFixBtn.Size = UDim2.new(0.48, 0, 1, 0)
tabFixBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
tabFixBtn.BorderSizePixel = 0
tabFixBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabFixBtn.Font = Enum.Font.GothamBold
tabFixBtn.TextSize = 12
tabFixBtn.Text = translations[currentLang].tabFixLag
tabFixBtn.Parent = tabHeaderFrame
Instance.new("UICorner", tabFixBtn).CornerRadius = UDim.new(0, 6)

local tabUtilsBtn = Instance.new("TextButton")
tabUtilsBtn.Size = UDim2.new(0.48, 0, 1, 0)
tabUtilsBtn.Position = UDim2.new(0.52, 0, 0, 0)
tabUtilsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tabUtilsBtn.BorderSizePixel = 0
tabUtilsBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
tabUtilsBtn.Font = Enum.Font.GothamBold
tabUtilsBtn.TextSize = 12
tabUtilsBtn.Text = translations[currentLang].tabUtils
tabUtilsBtn.Parent = tabHeaderFrame
Instance.new("UICorner", tabUtilsBtn).CornerRadius = UDim.new(0, 6)

local contentFixLag = Instance.new("ScrollingFrame")
contentFixLag.Size = UDim2.new(1, -10, 1, -80)
contentFixLag.Position = UDim2.new(0, 5, 0, 75)
contentFixLag.BackgroundTransparency = 1
contentFixLag.CanvasSize = UDim2.new(0, 0, 0, 260)
contentFixLag.ScrollBarThickness = 3
contentFixLag.Visible = true
contentFixLag.Parent = mainFrame

local layoutFix = Instance.new("UIListLayout")
layoutFix.Padding = UDim.new(0, 8)
layoutFix.HorizontalAlignment = Enum.HorizontalAlignment.Center
layoutFix.Parent = contentFixLag

local contentUtils = Instance.new("ScrollingFrame")
contentUtils.Size = UDim2.new(1, -10, 1, -80)
contentUtils.Position = UDim2.new(0, 5, 0, 75)
contentUtils.BackgroundTransparency = 1
contentUtils.CanvasSize = UDim2.new(0, 0, 0, 260)
contentUtils.ScrollBarThickness = 3
contentUtils.Visible = false
contentUtils.Parent = mainFrame

local layoutUtils = Instance.new("UIListLayout")
layoutUtils.Padding = UDim.new(0, 8)
layoutUtils.HorizontalAlignment = Enum.HorizontalAlignment.Center
layoutUtils.Parent = contentUtils

tabFixBtn.MouseButton1Click:Connect(function()
    contentFixLag.Visible = true
    contentUtils.Visible = false
    tabFixBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    tabFixBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabUtilsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabUtilsBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

tabUtilsBtn.MouseButton1Click:Connect(function()
    contentFixLag.Visible = false
    contentUtils.Visible = true
    tabUtilsBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    tabUtilsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabFixBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabFixBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

local function makeBtn(parent, textKey, color, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 38)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 12
    b.Font = Enum.Font.GothamSemibold
    b.Text = translations[currentLang][textKey] or textKey
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

-- ==================== HỆ THỐNG FIX LAG ====================

makeBtn(contentFixLag, "fixLight", Color3.fromRGB(60, 60, 90), function()
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

makeBtn(contentFixLag, "fixMed", Color3.fromRGB(80, 70, 40), function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 2
    Workspace.Terrain.WaterWaveSize = 0
    Workspace.Terrain.WaterWaveSpeed = 0
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

makeBtn(contentFixLag, "fixMax", Color3.fromRGB(120, 40, 40), function()
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
        end
    end
end)

makeBtn(contentFixLag, "restore", Color3.fromRGB(40, 100, 40), function()
    Lighting.GlobalShadows = originalSettings.Lighting.GlobalShadows
    Lighting.FogEnd = originalSettings.Lighting.FogEnd
    Lighting.Brightness = originalSettings.Lighting.Brightness
    Workspace.Terrain.WaterTransparency = 0
    for obj, mat in pairs(originalSettings.Parts) do
        if obj and obj.Parent then
            obj.Material = mat
            obj.CastShadow = true
        end
    end
end)

-- ==================== TIỆN ÍCH (ON/OFF SIÊU NHẠY) ====================

-- Noclip (Bản gốc mượt mà, bấm đổi trạng thái ON/OFF ngay lập tức)
local noclipActive = false
local noclipBtn = makeBtn(contentUtils, "noclipOff", Color3.fromRGB(50, 50, 50), function()
    noclipActive = not noclipActive
    if noclipActive then
        noclipBtn.Text = translations[currentLang].noclipOn
        noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    else
        noclipBtn.Text = translations[currentLang].noclipOff
        noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

RunService.Stepped:Connect(function()
    if noclipActive and localPlayer.Character then
        for _, part in ipairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Chống Rơi Xuống Void (Anti-Void)
local antiVoidActive = false
local antiVoidPart = nil
local antiVoidBtn = makeBtn(contentUtils, "antiVoidOff", Color3.fromRGB(50, 50, 50), function()
    antiVoidActive = not antiVoidActive
    if antiVoidActive then
        antiVoidBtn.Text = translations[currentLang].antiVoidOn
        antiVoidBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        if not antiVoidPart then
            antiVoidPart = Instance.new("Part")
            antiVoidPart.Size = Vector3.new(3000, 5, 3000)
            antiVoidPart.Position = Vector3.new(0, -50, 0)
            antiVoidPart.Anchored = true
            antiVoidPart.Transparency = 0.9
            antiVoidPart.Color = Color3.fromRGB(0, 255, 128)
            antiVoidPart.Parent = Workspace
        else
            antiVoidPart.Parent = Workspace
        end
    else
        antiVoidBtn.Text = translations[currentLang].antiVoidOff
        antiVoidBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        if antiVoidPart then antiVoidPart.Parent = nil end
    end
end)

-- Fast Interact (Nhặt nhanh)
makeBtn(contentUtils, "fastInteract", Color3.fromRGB(60, 100, 60), function()
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

-- Nút Đổi Ngôn Ngữ
makeBtn(contentUtils, "langBtn", Color3.fromRGB(70, 50, 90), function()
    currentLang = (currentLang == "vi") and "en" or "vi"
    titleLabel.Text = translations[currentLang].title
    tabFixBtn.Text = translations[currentLang].tabFixLag
    tabUtilsBtn.Text = translations[currentLang].tabUtils
    noclipBtn.Text = translations[currentLang][noclipActive and "noclipOn" or "noclipOff"]
    antiVoidBtn.Text = translations[currentLang][antiVoidActive and "antiVoidOn" or "antiVoidOff"]
end)
