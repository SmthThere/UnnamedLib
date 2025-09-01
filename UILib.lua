local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

local existingGui = localPlayer:WaitForChild("PlayerGui"):FindFirstChild("ToggleUI")
if existingGui then
  existingGui:Destroy()
end

local gui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
gui.Name = "ToggleUI"
gui.ResetOnSpawn = false

local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0, 420, 0, 280)
mainContainer.Position = UDim2.new(0.5, -210, 0.5, -140)
mainContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainContainer.BorderSizePixel = 0
mainContainer.Active = true
mainContainer.Parent = gui
Instance.new("UICorner", mainContainer).CornerRadius = UDim.new(0, 12)

-- Drop shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 6, 1, 6)
shadow.Position = UDim2.new(0, -3, 0, -3)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = -1
shadow.Parent = mainContainer
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 15)

-- Top bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 32)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
topBar.BorderSizePixel = 0
topBar.Parent = mainContainer
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)

-- Custom dragging for main container
local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainContainer.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Text = "Modern UI Library"
titleLabel.Size = UDim2.new(1, -64, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.Parent = topBar

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 24, 0, 24)
minimizeButton.Position = UDim2.new(1, -56, 0, 4)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.Text = "−"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 16
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.AutoButtonColor = false
minimizeButton.Parent = topBar
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -28, 0, 4)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.Text = "×"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.AutoButtonColor = false
closeButton.Parent = topBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 120, 1, -32)
sidebar.Position = UDim2.new(0, 0, 0, 32)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainContainer

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 12)
sidebarCorner.Parent = sidebar

local tabContainer = Instance.new("ScrollingFrame")
tabContainer.Name = "TabContainer"
tabContainer.Size = UDim2.new(1, 0, 1, -16)
tabContainer.Position = UDim2.new(0, 0, 0, 8)
tabContainer.BackgroundTransparency = 1
tabContainer.ScrollBarThickness = 4
tabContainer.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
tabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabContainer.Parent = sidebar

local tabLayout = Instance.new("UIListLayout")
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 4)
tabLayout.Parent = tabContainer

local tabPadding = Instance.new("UIPadding")
tabPadding.PaddingLeft = UDim.new(0, 8)
tabPadding.PaddingRight = UDim.new(0, 8)
tabPadding.PaddingTop = UDim.new(0, 8)
tabPadding.PaddingBottom = UDim.new(0, 8)
tabPadding.Parent = tabContainer

-- Content area
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -120, 1, -32)
contentArea.Position = UDim2.new(0, 120, 0, 32)
contentArea.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
contentArea.BorderSizePixel = 0
contentArea.Parent = mainContainer

-- Content area corner
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 12)
contentCorner.Parent = contentArea

local Lib = {}
Lib.tabs = {}
Lib.currentTab = nil

function Lib:SetTitle(newTitle)
    titleLabel.Text = newTitle or "Modern UI Library"
end

function Lib:NewTab(tabName)
    local tab = {
        name = tabName,
        elements = {},
        button = nil,
        container = nil
    }

    -- Tab button
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "Tab"
    tabButton.Size = UDim2.new(1, 0, 0, 32)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.Text = tabName
    tabButton.TextXAlignment = Enum.TextXAlignment.Center
    tabButton.AutoButtonColor = false
    tabButton.LayoutOrder = #self.tabs + 1
    tabButton.Parent = tabContainer
    Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 8)

    -- Tab content container
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, -16, 1, -16)
    tabContent.Position = UDim2.new(0, 8, 0, 8)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 6
    tabContent.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabContent.Visible = false
    tabContent.Parent = contentArea

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = tabContent

    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingLeft = UDim.new(0, 12)
    contentPadding.PaddingRight = UDim.new(0, 16)
    contentPadding.PaddingTop = UDim.new(0, 12)
    contentPadding.PaddingBottom = UDim.new(0, 12)
    contentPadding.Parent = tabContent

    tab.button = tabButton
    tab.container = tabContent

    -- Tab switching logic
    tabButton.MouseButton1Click:Connect(function()
        self:SwitchTab(tabName)
    end)

    -- Hover effects
    tabButton.MouseEnter:Connect(function()
        if self.currentTab ~= tabName then
            TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            }):Play()
        end
    end)

    tabButton.MouseLeave:Connect(function()
        if self.currentTab ~= tabName then
            TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            }):Play()
        end
    end)

    -- Tab methods
    function tab:AddButton(buttonText, callback, layoutOrder)
        local button = Instance.new("TextButton")
        button.Name = buttonText .. "Button"
        button.Size = UDim2.new(1, -12, 0, 32)
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 14
        button.Text = buttonText
        button.TextXAlignment = Enum.TextXAlignment.Center
        button.AutoButtonColor = false
        button.LayoutOrder = layoutOrder or (#self.elements + 1)
        button.Parent = self.container
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

        -- Hover effects
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(80, 80, 80),
                Size = UDim2.new(1, -8, 0, 30)
            }):Play()
        end)

        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                Size = UDim2.new(1, -12, 0, 32)
            }):Play()
        end)

        button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)

        table.insert(self.elements, button)
        return button
    end

    function tab:AddToggle(toggleText, statusText, callback, layoutOrder)
        local toggled = false

        local toggle = Instance.new("TextButton")
        toggle.Name = toggleText .. "Toggle"
        toggle.Size = UDim2.new(1, -12, 0, 32)
        toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggle.Font = Enum.Font.GothamBold
        toggle.TextSize = 14
        toggle.Text = toggleText
        toggle.TextXAlignment = Enum.TextXAlignment.Center
        toggle.AutoButtonColor = false
        toggle.LayoutOrder = layoutOrder or (#self.elements + 1)
        toggle.Parent = self.container
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

        toggle.MouseEnter:Connect(function()
            TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, -8, 0, 30)
            }):Play()
        end)

        toggle.MouseLeave:Connect(function()
            TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, -12, 0, 32)
            }):Play()
        end)

        toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            toggle.Text = toggled and (toggleText .. " - " .. statusText) or toggleText
            toggle.BackgroundColor3 = toggled and Color3.fromRGB(70, 150, 70) or Color3.fromRGB(50, 50, 50)
            if callback then
                callback(toggled)
            end
        end)

        table.insert(self.elements, toggle)
        return toggle
    end

    function tab:AddSlider(labelText, minValue, maxValue, defaultValue, onChanged, layoutOrder)
        local sliderContainer = Instance.new("Frame")
        sliderContainer.Size = UDim2.new(1, -12, 0, 50)
        sliderContainer.BackgroundTransparency = 1
        sliderContainer.LayoutOrder = layoutOrder or (#self.elements + 1)
        sliderContainer.Parent = self.container

        local label = Instance.new("TextLabel")
        label.Text = labelText
        label.Size = UDim2.new(1, 0, 0, 20)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = sliderContainer

        local sliderBar = Instance.new("Frame")
        sliderBar.Size = UDim2.new(1, -50, 0, 8)
        sliderBar.Position = UDim2.new(0, 8, 0, 26)
        sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        sliderBar.BorderSizePixel = 0
        sliderBar.Parent = sliderContainer
        Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(120, 70, 180)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBar
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local handle = Instance.new("Frame")
        handle.Size = UDim2.new(0, 14, 0, 14)
        handle.Position = UDim2.new(fill.Size.X.Scale, -7, 0.5, -7)
        handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        handle.BorderSizePixel = 0
        handle.ZIndex = 2
        handle.Parent = sliderBar
        Instance.new("UICorner", handle).CornerRadius = UDim.new(1, 0)

        local valueLabel = Instance.new("TextLabel")
        valueLabel.Text = tostring(defaultValue)
        valueLabel.Position = UDim2.new(1, -40, 0, 24)
        valueLabel.Size = UDim2.new(0, 40, 0, 18)
        valueLabel.BackgroundTransparency = 1
        valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        valueLabel.TextSize = 12
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextXAlignment = Enum.TextXAlignment.Center
        valueLabel.Parent = sliderContainer

        local sliderDragging = false

        local function updateInput(x)
            local absPos  = sliderBar.AbsolutePosition.X
            local absSize = sliderBar.AbsoluteSize.X
            local percent = math.clamp((x - absPos) / absSize, 0, 1)
            local newVal  = math.floor(minValue + (maxValue - minValue) * percent)

            if math.abs(newVal - defaultValue) <= 1 then
                newVal = defaultValue
                percent = (defaultValue - minValue) / (maxValue - minValue)
            end

            fill.Size       = UDim2.new(percent, 0, 1, 0)
            handle.Position = UDim2.new(percent, -7, 0.5, -7)
            valueLabel.Text = tostring(newVal)

            if onChanged then onChanged(newVal) end
        end

        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                sliderDragging = true
                updateInput(input.Position.X)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                          or input.UserInputType == Enum.UserInputType.Touch) then
                updateInput(input.Position.X)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                sliderDragging = false
            end
        end)

        table.insert(self.elements, sliderContainer)
        return sliderContainer
    end

    function tab:AddDropdown(name, options, default, callback, layoutOrder)
        local dropdownOpen = false
        local selectedOption = default

        local optionHeight = 24
        local maxDropdownHeight = 100

        local container = Instance.new("Frame")
        container.Name = name .. "Dropdown"
        container.Size = UDim2.new(1, -8, 0, 48)
        container.BackgroundTransparency = 1
        container.LayoutOrder = layoutOrder or (#self.elements + 1)
        container.Parent = self.container

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "TitleLabel"
        titleLabel.Text = name
        titleLabel.Size = UDim2.new(1, 0, 0, 20)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 13
        titleLabel.Parent = container

        local dropdownButton = Instance.new("Frame")
        dropdownButton.Name = "DropdownButton"
        dropdownButton.Size = UDim2.new(1, -24, 0, 32)
        dropdownButton.Position = UDim2.new(0, 0, 0, 24)
        dropdownButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        dropdownButton.BorderSizePixel = 0
        dropdownButton.Parent = container
        Instance.new("UICorner", dropdownButton).CornerRadius = UDim.new(0, 8)

        local selectionLabel = Instance.new("TextLabel")
        selectionLabel.Name = "SelectionLabel"
        selectionLabel.Text = selectedOption and tostring(selectedOption) or "None"
        selectionLabel.Size = UDim2.new(1, -32, 1, 0)
        selectionLabel.Position = UDim2.new(0, 10, 0, 0)
        selectionLabel.BackgroundTransparency = 1
        selectionLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        selectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        selectionLabel.TextYAlignment = Enum.TextYAlignment.Center
        selectionLabel.Font = Enum.Font.Gotham
        selectionLabel.TextSize = 12
        selectionLabel.TextWrapped = true
        selectionLabel.Parent = dropdownButton

        local arrowButton = Instance.new("TextButton")
        arrowButton.Name = "ArrowButton"
        arrowButton.Size = UDim2.new(0, 20, 0, 20)
        arrowButton.Position = UDim2.new(1, -24, 0.5, -10)
        arrowButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        arrowButton.Text = "▼"
        arrowButton.Font = Enum.Font.GothamBold
        arrowButton.TextSize = 10
        arrowButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        arrowButton.AutoButtonColor = false
        arrowButton.ZIndex = 2
        arrowButton.Parent = dropdownButton
        Instance.new("UICorner", arrowButton).CornerRadius = UDim.new(0, 6)

        local clearButton = Instance.new("TextButton")
        clearButton.Name = "ClearButton"
        clearButton.Size = UDim2.new(0, 20, 0, 20)
        clearButton.Position = UDim2.new(1, -16, 0, 30)
        clearButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        clearButton.Text = "×"
        clearButton.Font = Enum.Font.GothamBold
        clearButton.TextSize = 14
        clearButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        clearButton.AutoButtonColor = false
        clearButton.ZIndex = 3
        clearButton.Parent = container
        Instance.new("UICorner", clearButton).CornerRadius = UDim.new(0, 6)

        local optionsContainer = Instance.new("Frame")
        optionsContainer.Name = "OptionsContainer"
        optionsContainer.Size = UDim2.new(1, -8, 0, 0)
        optionsContainer.BackgroundTransparency = 1
        optionsContainer.LayoutOrder = (layoutOrder or (#self.elements + 1)) + 0.1
        optionsContainer.Visible = false
        optionsContainer.Parent = self.container

        local optionsFrame = Instance.new("ScrollingFrame")
        optionsFrame.Name = "OptionsFrame"
        optionsFrame.Size = UDim2.new(1, 0, 1, 0)
        optionsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        optionsFrame.BorderSizePixel = 0
        optionsFrame.ScrollBarThickness = 4
        optionsFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        optionsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        optionsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        optionsFrame.Parent = optionsContainer
        Instance.new("UICorner", optionsFrame).CornerRadius = UDim.new(0, 8)

        local optionsLayout = Instance.new("UIListLayout")
        optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
        optionsLayout.Padding = UDim.new(0, 2)
        optionsLayout.Parent = optionsFrame

        local optionsPadding = Instance.new("UIPadding")
        optionsPadding.PaddingLeft = UDim.new(0, 6)
        optionsPadding.PaddingRight = UDim.new(0, 6)
        optionsPadding.PaddingTop = UDim.new(0, 4)
        optionsPadding.PaddingBottom = UDim.new(0, 4)
        optionsPadding.Parent = optionsFrame

        for i, option in ipairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Name = "Option" .. i
            optionButton.Size = UDim2.new(1, 0, 0, optionHeight)
            optionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            optionButton.TextColor3 = Color3.fromRGB(220, 220, 220)
            optionButton.Font = Enum.Font.Gotham
            optionButton.TextSize = 12
            optionButton.TextXAlignment = Enum.TextXAlignment.Left
            optionButton.Text = "  " .. tostring(option)
            optionButton.AutoButtonColor = false
            optionButton.LayoutOrder = i
            optionButton.Parent = optionsFrame
            Instance.new("UICorner", optionButton).CornerRadius = UDim.new(0, 6)

            optionButton.MouseEnter:Connect(function()
                TweenService:Create(optionButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(120, 70, 180)
                }):Play()
            end)

            optionButton.MouseLeave:Connect(function()
                TweenService:Create(optionButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                }):Play()
            end)

            optionButton.MouseButton1Click:Connect(function()
                selectedOption = option
                selectionLabel.Text = tostring(selectedOption)
                if callback then callback(selectedOption) end

                dropdownOpen = false
                optionsContainer.Visible = false
                optionsContainer.Size = UDim2.new(1, -8, 0, 0)
                TweenService:Create(arrowButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Rotation = 0
                }):Play()
            end)
        end

        local function toggleDropdown()
            dropdownOpen = not dropdownOpen

            if dropdownOpen then
                local totalHeight = #options * (optionHeight + 2) + 8
                local targetHeight = math.min(totalHeight, maxDropdownHeight)

                optionsContainer.Visible = true
                optionsContainer.Size = UDim2.new(1, -8, 0, targetHeight)

                TweenService:Create(arrowButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Rotation = 180
                }):Play()
            else
                optionsContainer.Visible = false
                optionsContainer.Size = UDim2.new(1, -8, 0, 0)

                TweenService:Create(arrowButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Rotation = 0
                }):Play()
            end
        end

        local function clearSelection()
            selectedOption = nil
            selectionLabel.Text = "None"
            if callback then callback(nil) end
        end

        arrowButton.MouseButton1Click:Connect(toggleDropdown)
        clearButton.MouseButton1Click:Connect(clearSelection)

        -- Hover effects
        arrowButton.MouseEnter:Connect(function()
            TweenService:Create(arrowButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            }):Play()
        end)

        arrowButton.MouseLeave:Connect(function()
            TweenService:Create(arrowButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            }):Play()
        end)

        clearButton.MouseEnter:Connect(function()
            TweenService:Create(clearButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(200, 60, 60)
            }):Play()
        end)

        clearButton.MouseLeave:Connect(function()
            TweenService:Create(clearButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            }):Play()
        end)

        table.insert(self.elements, container)
        return container
    end

    self.tabs[tabName] = tab

    -- Auto-select first tab
    if #self.tabs == 1 then
        self:SwitchTab(tabName)
    end

    return tab
end

function Lib:SwitchTab(tabName)
    local targetTab = self.tabs[tabName]
    if not targetTab then return end

    -- Hide current tab
    if self.currentTab then
        local currentTabData = self.tabs[self.currentTab]
        currentTabData.container.Visible = false
        TweenService:Create(currentTabData.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            TextColor3 = Color3.fromRGB(200, 200, 200)
        }):Play()
    end

    -- Show new tab
    targetTab.container.Visible = true
    TweenService:Create(targetTab.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = Color3.fromRGB(120, 70, 180),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()

    self.currentTab = tabName
end

-- Button hover effects
minimizeButton.MouseEnter:Connect(function()
    TweenService:Create(minimizeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    }):Play()
end)

minimizeButton.MouseLeave:Connect(function()
    TweenService:Create(minimizeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    }):Play()
end)

closeButton.MouseEnter:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
end)

closeButton.MouseLeave:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    }):Play()
end)

local minimized = false

local function toggleMinimize()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 420, 0, 32) or UDim2.new(0, 420, 0, 280)

    sidebar.Visible = not minimized
    contentArea.Visible = not minimized

    TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = targetSize
    }):Play()
end

-- Create reopen button (initially hidden)
local reopenButton = Instance.new("TextButton")
reopenButton.Name = "ReopenButton"
reopenButton.Size = UDim2.new(0, 100, 0, 30)
reopenButton.Position = UDim2.new(0.5, -50, 0, 20)
reopenButton.BackgroundColor3 = Color3.fromRGB(120, 70, 180)
reopenButton.Text = "Open UI"
reopenButton.Font = Enum.Font.GothamBold
reopenButton.TextSize = 14
reopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenButton.AutoButtonColor = false
reopenButton.Visible = false
reopenButton.Active = true
reopenButton.ZIndex = 1001
reopenButton.Parent = gui
Instance.new("UICorner", reopenButton).CornerRadius = UDim.new(0, 8)

-- Custom dragging for reopen button
local reopenDragging = false
local reopenDragStart = nil
local reopenStartPos = nil

reopenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        reopenDragging = true
        reopenDragStart = input.Position
        reopenStartPos = reopenButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if reopenDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - reopenDragStart
        reopenButton.Position = UDim2.new(reopenStartPos.X.Scale, reopenStartPos.X.Offset + delta.X, reopenStartPos.Y.Scale, reopenStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        reopenDragging = false
    end
end)

-- Reopen button shadow
local reopenShadow = Instance.new("Frame")
reopenShadow.Size = UDim2.new(1, 4, 1, 4)
reopenShadow.Position = UDim2.new(0, -2, 0, -2)
reopenShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
reopenShadow.BackgroundTransparency = 0.8
reopenShadow.ZIndex = -1
reopenShadow.Parent = reopenButton
Instance.new("UICorner", reopenShadow).CornerRadius = UDim.new(0, 10)

-- Reopen button hover effects
reopenButton.MouseEnter:Connect(function()
    TweenService:Create(reopenButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = Color3.fromRGB(140, 90, 200),
        Size = UDim2.new(0, 105, 0, 32)
    }):Play()
end)

reopenButton.MouseLeave:Connect(function()
    TweenService:Create(reopenButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = Color3.fromRGB(120, 70, 180),
        Size = UDim2.new(0, 100, 0, 30)
    }):Play()
end)

-- Animation function (moved before reopenUI to fix reference error)
local function playExecutionAnimation()
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)

    TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 420, 0, 280),
        Position = UDim2.new(0.5, -210, 0.5, -140)
    }):Play()
end

local function closeUI()
    -- Calculate center position for animation target
    local screenCenter = gui.AbsoluteSize / 2
    local targetX = screenCenter.X - 12 -- Center position, offset by half of final size (24/2)
    local targetY = screenCenter.Y - 12 -- Center position, offset by half of final size (24/2)

    -- Hide all components except main container background during animation
    topBar.Visible = false
    sidebar.Visible = false
    contentArea.Visible = false

    -- Set reopen button to the center position initially (but keep it invisible)
    reopenButton.Position = UDim2.new(0, targetX, 0, targetY)
    reopenButton.Size = UDim2.new(0, 24, 0, 24) -- Start with small size
    reopenButton.BackgroundTransparency = 1
    reopenButton.TextTransparency = 1
    reopenButton.Visible = true

    -- Animate main container shrinking to small size and moving to center position
    local shrinkTween = TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0, targetX, 0, targetY)
    })

    -- Fade out main container
    local fadeTween = TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    })

    -- Fade out shadow
    local shadowFadeTween = TweenService:Create(shadow, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    })

    shrinkTween:Play()
    fadeTween:Play()
    shadowFadeTween:Play()

    -- After shrink animation completes, transform into reopen button
    shrinkTween.Completed:Connect(function()
        mainContainer.Visible = false

        -- Reset main container properties for when it reopens
        mainContainer.Size = UDim2.new(0, 420, 0, 280)
        mainContainer.Position = UDim2.new(0.5, -210, 0.5, -140)
        mainContainer.BackgroundTransparency = 0
        shadow.BackgroundTransparency = 0.7

        -- Restore component visibility for when UI reopens
        topBar.Visible = true
        sidebar.Visible = true
        contentArea.Visible = true

        -- Animate reopen button to its normal size and appearance at top middle
        local reopenGrowTween = TweenService:Create(reopenButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 100, 0, 30),
            Position = UDim2.new(0.5, -50, 0, 20), -- Top middle position
            BackgroundTransparency = 0,
            TextTransparency = 0
        })

        reopenGrowTween:Play()
    end)
end

local function reopenUI()
    -- Animate reopen button shrinking and fading
    local reopenShrinkTween = TweenService:Create(reopenButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundTransparency = 1,
        TextTransparency = 1
    })

    reopenShrinkTween:Play()

    reopenShrinkTween.Completed:Connect(function()
        reopenButton.Visible = false

        -- Ensure all components are visible before showing main container
        topBar.Visible = true
        sidebar.Visible = true
        contentArea.Visible = true
        mainContainer.BackgroundTransparency = 0
        shadow.BackgroundTransparency = 0.7

        mainContainer.Visible = true
        playExecutionAnimation()
    end)
end

reopenButton.MouseButton1Click:Connect(reopenUI)
minimizeButton.MouseButton1Click:Connect(toggleMinimize)
closeButton.MouseButton1Click:Connect(closeUI)

playExecutionAnimation()

-- Notification system
local activeNotifications = {}
local notificationSpacing = 80
local removalQueue = {}
local isProcessingRemovals = false

local function updateNotificationPositions()
    for i, notification in ipairs(activeNotifications) do
        if notification and notification.Parent then
            local targetY = 20 + (i - 1) * notificationSpacing
            TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -320, 0, targetY)
            }):Play()
        end
    end
end

local function processRemovalQueue()
    if isProcessingRemovals or #removalQueue == 0 then
        return
    end

    isProcessingRemovals = true

    while #removalQueue > 0 do
        local notificationToRemove = table.remove(removalQueue, 1)

        -- Remove from active notifications
        for i, notification in ipairs(activeNotifications) do
            if notification == notificationToRemove then
                table.remove(activeNotifications, i)
                break
            end
        end

        -- Small delay to prevent animation conflicts
        task.wait(0.05)
    end

    -- Update positions after all removals are processed
    updateNotificationPositions()
    isProcessingRemovals = false
end

local function removeNotificationFromStack(notificationContainer)
    -- Add to removal queue instead of removing immediately
    table.insert(removalQueue, notificationContainer)

    -- Start processing queue if not already processing
    if not isProcessingRemovals then
        task.spawn(processRemovalQueue)
    end
end

function Lib:Notify(title, message, errorMode, duration)
    if type(errorMode) == "number" then
        duration = errorMode
        errorMode = false
    else
        errorMode = errorMode or false
        duration = duration or 5
    end

    if errorMode then
        title = title or "ERROR!"
    end

    local notificationContainer = Instance.new("Frame")
    notificationContainer.Name = "NotificationContainer"
    notificationContainer.Size = UDim2.new(0, 300, 0, 70)
    notificationContainer.Position = UDim2.new(1, 50, 0, 20) -- Start from off-screen right
    notificationContainer.BackgroundColor3 = errorMode and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(45, 45, 45)
    notificationContainer.BorderSizePixel = 0
    notificationContainer.ZIndex = 1002
    notificationContainer.Parent = gui

    -- Insert new notification at the beginning (top position)
    table.insert(activeNotifications, 1, notificationContainer)

    -- Update positions of all notifications to push existing ones down
    updateNotificationPositions()

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = notificationContainer

    local containerShadow = Instance.new("Frame")
    containerShadow.Size = UDim2.new(1, 6, 1, 6)
    containerShadow.Position = UDim2.new(0, -3, 0, -3)
    containerShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    containerShadow.BackgroundTransparency = 0.7
    containerShadow.ZIndex = 1001
    containerShadow.BorderSizePixel = 0
    containerShadow.Parent = notificationContainer

    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 11)
    shadowCorner.Parent = containerShadow

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Text = title or "Notification"
    titleLabel.Size = UDim2.new(1, -50, 0, 20)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = errorMode and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextScaled = false
    titleLabel.ZIndex = 1003
    titleLabel.Parent = notificationContainer

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "MessageLabel"
    messageLabel.Text = message or ""
    messageLabel.Size = UDim2.new(1, -50, 0, 20)
    messageLabel.Position = UDim2.new(0, 10, 0, 25)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextColor3 = errorMode and Color3.fromRGB(255, 150, 150) or Color3.fromRGB(200, 200, 200)
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Center
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 12
    messageLabel.TextScaled = false
    messageLabel.TextWrapped = true
    messageLabel.ZIndex = 1003
    messageLabel.Parent = notificationContainer

    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(1, -20, 0, 4)
    progressBar.Position = UDim2.new(0, 10, 1, -8)
    progressBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    progressBar.BorderSizePixel = 0
    progressBar.ZIndex = 1003
    progressBar.Parent = notificationContainer

    local progressFill = Instance.new("Frame")
    progressFill.Name = "ProgressFill"
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    progressFill.Position = UDim2.new(0, 0, 0, 0)
    progressFill.BackgroundColor3 = errorMode and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(120, 70, 180)
    progressFill.BorderSizePixel = 0
    progressFill.ZIndex = 1004
    progressFill.Parent = progressBar

    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 2)
    progressCorner.Parent = progressBar

    local progressFillCorner = Instance.new("UICorner")
    progressFillCorner.CornerRadius = UDim.new(0, 2)
    progressFillCorner.Parent = progressFill

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -28, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    closeButton.Text = "x"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.AutoButtonColor = false
    closeButton.ZIndex = 1005
    closeButton.BorderSizePixel = 0
    closeButton.Parent = notificationContainer

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton

    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        }):Play()
    end)

    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        }):Play()
    end)

    local isClosing = false

    local function closeNotification()
        if not notificationContainer.Parent or isClosing then return end
        isClosing = true

        -- Animate notification sliding out to the right
        TweenService:Create(notificationContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 50, 0, notificationContainer.Position.Y.Offset)
        }):Play()

        -- Fade out the shadow
        if containerShadow then
            TweenService:Create(containerShadow, TweenInfo.new(0.4), {
                BackgroundTransparency = 1
            }):Play()
        end

        -- Remove from stack and destroy after animation completes
        task.spawn(function()
            task.wait(0.4) -- Wait for slide-out animation to complete
            removeNotificationFromStack(notificationContainer)
            task.wait(0.1) -- Small additional wait for queue processing
            if notificationContainer.Parent then
                notificationContainer:Destroy()
            end
        end)
    end

    closeButton.MouseButton1Click:Connect(closeNotification)

    -- Animate notification sliding in from the right to the top position
    TweenService:Create(notificationContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 0, 20)
    }):Play()

    -- Animate progress bar
    TweenService:Create(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 1, 0)
    }):Play()

    -- Auto-close notification after duration
    task.spawn(function()
        task.wait(duration)
        if notificationContainer.Parent then
            closeNotification()
        end
    end)
end

getgenv().Notify = function(title, message, errorMode, duration)
    return Lib:Notify(title, message, errorMode, duration)
end

-- Example usage with new API //////////
Lib:SetTitle("Cool Library")

-- Create tabs using NewTab
local mainTab = Lib:NewTab("Main")
local playerTab = Lib:NewTab("Player")
local visualTab = Lib:NewTab("Visual")
local miscTab = Lib:NewTab("Misc")
local settingsTab = Lib:NewTab("Settings")
local testTab = Lib:NewTab("Test")
local testTab2 = Lib:NewTab("Test2")
local testTab3 = Lib:NewTab("Test3")
local testTab4 = Lib:NewTab("Test4")


-- Main tab elements using new API
local testButtonCount = 0
mainTab:AddButton("Test Button", function()
    testButtonCount = testButtonCount + 1
    local duration = (testButtonCount % 3 == 0) and 1 or 3
    Lib:Notify("Button", "Button was clicked! (Duration: " .. duration .. "s)", duration)
end, 1)

local toggleCount = 0
mainTab:AddToggle("Test Toggle", "Active", function(isOn)
    toggleCount = toggleCount + 1
    local duration = (toggleCount % 3 == 0) and 1 or 3
    Lib:Notify("Toggle", "Toggle is now: " .. tostring(isOn) .. " (Duration: " .. duration .. "s)", duration)
end, 2)

local dropdownCount = 0
mainTab:AddDropdown("Test Dropdown", {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"}, nil, function(selected)
    if selected ~= nil then
        dropdownCount = dropdownCount + 1
        local duration = (dropdownCount % 3 == 0) and 1 or 3
        Lib:Notify("Dropdown", "Selected: " .. tostring(selected) .. " (Duration: " .. duration .. "s)", duration)
    end
end, 3)

-- Player tab elements
playerTab:AddSlider("Walk Speed", 1, 100, 16, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end, 1)

playerTab:AddSlider("Jump Power", 1, 200, 50, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
end, 2)

-- Visual tab elements
visualTab:AddButton("Test Visual", function()
    Lib:Notify("Visual", "Visual button clicked!", 5)
end, 1)

visualTab:AddToggle("Random Toggle cos why not", "Enabled", function(isOn)
    Lib:Notify("Visual", "Visual toggle: " .. tostring(isOn), 2)
end, 2)

-- Misc tab elements
miscTab:AddButton("Booton",function()
    Lib:Notify("Misc", "Misc booton clickied", 2)
    end, 1)

-- Welcome notification
Lib:Notify("Welcome", "UI Library Loaded boii", 5)

if game.Players.LocalPlayer.Character then
    task.wait(2)
    Lib:Notify(nil, "All systems operational", true, 3)
end
