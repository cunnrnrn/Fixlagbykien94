-- ==========================================================
-- SCRIPT: √12kientomato Hub Pro Max (Extreme FixLag & Smart Noclip)
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
        tabFixLag = "⚡ Fix Lag (1-100)",
        tabUtils = "🛠️ Tiện Ích",
        fixLight = "🔹 Fix Lag Nhẹ (Cấp 25)",
        fixMed = "🔸 Fix Lag Vừa (Cấp 50 - Xi măng)",
        fixHeavy = "🔥 Fix Lag Nặng (Cấp 75 - Xóa Decal/Mesh)",
        fixMax = "🚀 Siêu Fix Lag 100% (Xóa Toàn Bộ Map)",
        restore = "🔄 Khôi Phục Gốc",
        noclipOff = "👻 Noclip: ĐANG TẮT",
        noclipOn = "👻 Noclip: ĐANG BẬT",
        antiVoidOff = "🛡️ Chống Void: ĐANG TẮT",
        antiVoidOn = "🛡️ Chống Void: ĐANG BẬT",
        fastInteract = "⚡ Nhặt Nhanh (0s)",
        langBtn = "🌐 Ngôn ngữ: Tiếng Việt"
    },
    en = {
        title = "√12kientomato Hub Pro Max",
        tabFixLag = "⚡ Fix Lag (1-100)",
        tabUtils = "🛠️ Utilities",
        fixLight = "🔹 Light Fix (Lv 25)",
        fixMed = "🔸 Medium Fix (Lv 50 - Plastic)",
        fixHeavy = "🔥 Heavy Fix (Lv 75 - Clean Textures)",
        fixMax = "🚀 Max Fix 100% (Wipe Map)",
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
        Brightness = Lighting.Brightness,
        Ambient = Lighting.Ambient
    },
    PartsData = {}
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

-- ==================== FIX LAG PHÂN CẤP (1% ĐẾN 100% EXTREME) ====================

makeBtn(contentFixLag, "fixLight", Color3.fromRGB(60, 60, 90), function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    print("[√12] Fix Lag Cấp 25: Đã tối ưu ánh sáng.")
end)

makeBtn(contentFixLag, "fixMed", Color3.fromRGB(80, 70, 40), function()
    Lighting.GlobalShadows = false
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if not originalSettings.PartsData[obj] then
                originalSettings.PartsData[obj] = {material = obj.Material, color = obj.Color, transparency = obj.Transparency}
            end
            obj.Material = Enum.Material.SmoothPlastic
        end
    end
    print("[√12] Fix Lag Cấp 50: Đã chuyển đổi toàn bộ vật liệu sang dạng xi măng/nhựa láng mịn.")
end)

makeBtn(contentFixLag, "fixHeavy", Color3.fromRGB(100, 50, 40), function()
    Lighting.GlobalShadows = false
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SpecialMesh") or obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj:Destroy()
        end
    end
    print("[√12] Fix Lag Cấp 75: Đã xóa toàn bộ decal, texture và hiệu ứng phụ.")
end)

makeBtn(contentFixLag, "fixMax", Color3.fromRGB(150, 30, 30), function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 0
    Workspace.Terrain.WaterTransparency = 1
    -- Cấp 100: Xóa triệt để các vật thể gây nặng máy / xóa bớt map không cần thiết
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" and not obj:IsDescendantOf(localPlayer.Character or grayish) then
            if not originalSettings.PartsData[obj] then
                originalSettings.PartsData[obj] = {material = obj.Material, color = obj.Color, transparency = obj.Transparency}
            end
            -- Biến các part thành trong suốt hoặc xóa hẳn nếu không phải sàn chính để cực kỳ nhẹ
            if obj.Size.Magnitude > 150 then
                obj.Transparency = 0.5
                obj.Material = Enum.Material.SmoothPlastic
            else
                obj.Transparency = 1
                obj.CanCollide = false
            end
        elseif obj:IsA("Model") and obj ~= localPlayer.Character and obj ~= Workspace:FindFirstChild("Terrain") then
            pcall(function()
                for _, p in ipairs(obj:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Transparency = 1
                        p.CanCollide = false
                    end
                end
            end)
        end
    end
    print("[√12] SIÊU FIX LAG 100%: Đã xóa sổ và tối ưu toàn bộ cấu trúc map cực đại!")
end)

makeBtn(contentFixLag, "restore", Color3.fromRGB(40, 100, 40), function()
    Lighting.GlobalShadows = originalSettings.Lighting.GlobalShadows
    Lighting.FogEnd = originalSettings.Lighting.FogEnd
    Lighting.Brightness = originalSettings.Lighting.Brightness
    Workspace.Terrain.WaterTransparency = 0
    for obj, data in pairs(originalSettings.PartsData) do
        if obj and obj.Parent then
            obj.Transparency = data.transparency or 0
            obj.Material = data.material
            obj.CanCollide = true
        end
    end
    print("[√12] Đã khôi phục trạng thái map ban đầu.")
end)

-- ==================== TIỆN ÍCH (NOCLIP & STATUS FIX) ====================

local noclipActive = false
local noclipBtn = makeBtn(contentUtils, "noclipOff", Color3.fromRGB(50, 50, 50), function()
    noclipActive = not noclipActive
    -- Cập nhật tức thì trạng thái nút bấm
    if noclipActive then
        noclipBtn.Text = translations[currentLang].noclipOn
        noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    else
        noclipBtn.Text = translations[currentLang].noclipOff
        noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- Noclip thông minh: Xuyên tường nhưng giữ vững chân trên mặt đất
RunService.Stepped:Connect(function()
    if noclipActive and localPlayer.Character then
        local char = localPlayer.Character
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                -- Cho phép xuyên qua mọi thứ TRỪ phần chân (giúp nhân vật không bị rơi xuống void)
                if part.Name == "HumanoidRootPart" or part.Name == "LeftFoot" or part.Name == "RightFoot" or part.Name == "LowerTorso" then
                    part.CanCollide = true
                else
                    part.CanCollide = false
                end
            end
        end
    end
end)

local antiVoidActive = false
local antiVoidPart = nil
local antiVoidBtn = makeBtn(contentUtils, "antiVoidOff", Color3.fromRGB(50, 50, 50), function()
    antiVoidActive = not antiVoidActive
    if antiVoidActive then
        antiVoidBtn.Text = translations[currentLang].antiVoidOn
        antiVoidBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        if not antiVoidPart then
            antiVoidPart = Instance.new("Part")
            antiVoidPart.Name = "AntiVoidPlatform"
            antiVoidPart.Size = Vector3.new(5000, 5, 5000)
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
    print("[√12] Đã bật nhặt vật phẩm tức thì.")
end)

makeBtn(contentUtils, "langBtn", Color3.fromRGB(70, 50, 90), function()
    currentLang = (currentLang == "vi") and "en" or "vi"
    titleLabel.Text = translations[currentLang].title
    tabFixBtn.Text = translations[currentLang].tabFixLag
    tabUtilsBtn.Text = translations[currentLang].tabUtils
    noclipBtn.Text = translations[currentLang][noclipActive and "noclipOn" or "noclipOff"]
    antiVoidBtn.Text = translations[currentLang][antiVoidActive and "antiVoidOn" or "antiVoidOff"]
end)
