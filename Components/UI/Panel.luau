local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local Theme = require(script.Parent.Theme)

local create = Vide.create

return function(props)
	props = props or {}

	return create "Frame" {
		Name = props.Name or "Panel",
		AnchorPoint = props.AnchorPoint,
		AutomaticSize = props.AutomaticSize,
		BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Surface,
		BorderSizePixel = 0,
		LayoutOrder = props.LayoutOrder,
		Position = props.Position,
		Size = props.Size or UDim2.fromOffset(360, 420),

		create "UICorner" {
			CornerRadius = props.CornerRadius or Theme.Radii.Panel,
		},

		create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = props.StrokeColor or Theme.Colors.Border,
			Thickness = props.StrokeThickness or 1,
			Transparency = 0.2,
		},

		create "UIPadding" {
			PaddingBottom = UDim.new(0, 18),
			PaddingLeft = UDim.new(0, 18),
			PaddingRight = UDim.new(0, 18),
			PaddingTop = UDim.new(0, 18),
		},

		create "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 14),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		if props.Title then
			create "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Bold,
				LayoutOrder = -2,
				Size = UDim2.fromScale(1, 0),
				Text = props.Title,
				TextColor3 = Theme.Colors.Text,
				TextSize = 22,
				TextXAlignment = Enum.TextXAlignment.Left,
			}
		else
			nil,

		if props.Subtitle then
			create "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Regular,
				LayoutOrder = -1,
				Size = UDim2.fromScale(1, 0),
				Text = props.Subtitle,
				TextColor3 = Theme.Colors.TextMuted,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			}
		else
			nil,

		table.unpack(props.Children or {}),
	}
end
