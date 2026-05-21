local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local Motion = require(script.Parent.Motion)
local Theme = require(script.Parent.Theme)

local create = Vide.create
local derive = Vide.derive
local source = Vide.source

local function read(value, fallback)
	if value == nil then
		return fallback
	end

	if type(value) == "function" then
		return value()
	end

	return value
end

return function(props)
	props = props or {}

	local hovered = source(false)
	local selected = derive(function()
		return read(props.Selected, false) == true
	end)

	local background = derive(function()
		if selected() then
			return Theme.Colors.SurfaceMuted
		end

		if hovered() then
			return Color3.fromRGB(48, 48, 48)
		end

		return props.BackgroundColor3 or Theme.Colors.SurfaceRaised
	end)
	local animatedBackground = Motion.tween(background, Motion.Duration.Fast)
	local animatedScale = Motion.scale(derive(function()
		return if selected() then 1.015 elseif hovered() then 1.01 else 1
	end), Motion.Duration.Fast, Motion.Damping.Soft)
	local animatedStrokeThickness = Motion.tween(derive(function()
		return if selected() then 2 else 1
	end), Motion.Duration.Fast)
	local animatedStrokeTransparency = Motion.tween(derive(function()
		return if selected() then 0 elseif hovered() then 0.02 else 0.15
	end), Motion.Duration.Fast)

	return create "TextButton" {
		Name = props.Name or "Card",
		AutoButtonColor = false,
		BackgroundColor3 = animatedBackground,
		BorderSizePixel = 0,
		LayoutOrder = props.LayoutOrder,
		Size = props.Size or UDim2.new(1, 0, 0, 96),
		Text = "",

		Activated = function(...)
			if props.OnActivated then
				props.OnActivated(...)
			end
		end,

		MouseEnter = function()
			hovered(true)
		end,

		MouseLeave = function()
			hovered(false)
		end,

		create "UICorner" {
			CornerRadius = props.CornerRadius or Theme.Radii.Control,
		},

		create "UIScale" {
			Scale = animatedScale,
		},

		create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = derive(function()
				return if selected() then Theme.Colors.AccentHover else Theme.Colors.Border
			end),
			Thickness = animatedStrokeThickness,
			Transparency = animatedStrokeTransparency,
		},

		create "UIPadding" {
			PaddingBottom = UDim.new(0, 12),
			PaddingLeft = UDim.new(0, 12),
			PaddingRight = UDim.new(0, 12),
			PaddingTop = UDim.new(0, 12),
		},

		create "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		if props.Title then
			create "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Bold,
				LayoutOrder = 1,
				Size = UDim2.fromScale(1, 0),
				Text = props.Title,
				TextColor3 = Theme.Colors.Text,
				TextSize = 16,
				TextXAlignment = Enum.TextXAlignment.Left,
			}
		else
			nil,

		if props.Description then
			create "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Regular,
				LayoutOrder = 2,
				Size = UDim2.fromScale(1, 0),
				Text = props.Description,
				TextColor3 = Theme.Colors.TextMuted,
				TextSize = 13,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			}
		else
			nil,

		table.unpack(props.Children or {}),
	}
end
