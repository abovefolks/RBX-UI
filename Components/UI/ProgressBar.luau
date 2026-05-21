local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local Motion = require(script.Parent.Motion)
local Theme = require(script.Parent.Theme)

local create = Vide.create
local derive = Vide.derive

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

	local percent = derive(function()
		return math.clamp(read(props.Value, 0), 0, 1)
	end)
	local animatedPercent = Motion.tween(percent, Motion.Duration.Slow)

	return create "Frame" {
		Name = props.Name or "ProgressBar",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.LayoutOrder,
		Size = props.Size or UDim2.new(1, 0, 0, 42),

		create "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		if props.Label then
			create "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Semibold,
				LayoutOrder = 1,
				Size = UDim2.fromScale(1, 0),
				Text = props.Label,
				TextColor3 = Theme.Colors.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
			}
		else
			nil,

		create "Frame" {
			BackgroundColor3 = Theme.Colors.SurfaceMuted,
			BorderSizePixel = 0,
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, 12),

			create "UICorner" {
				CornerRadius = UDim.new(1, 0),
			},

			create "Frame" {
				BackgroundColor3 = props.FillColor or Theme.Colors.Accent,
				BorderSizePixel = 0,
				Size = derive(function()
					return UDim2.fromScale(animatedPercent(), 1)
				end),

				create "UICorner" {
					CornerRadius = UDim.new(1, 0),
				},
			},
		},
	}
end
