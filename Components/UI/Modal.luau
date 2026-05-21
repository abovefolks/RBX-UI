local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(script.Parent.Button)
local IconButton = require(script.Parent.IconButton)
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

	local visible = derive(function()
		return read(props.Visible, false) == true
	end)
	local animatedBackdropTransparency = Motion.tween(derive(function()
		return if visible() then 0.32 else 1
	end), Motion.Duration.Normal)
	local animatedDialogScale = Motion.booleanScale(visible, 1, 0.92, Motion.Duration.Slow, Motion.Damping.Snappy)

	local function close()
		if props.OnClose then
			props.OnClose()
		elseif type(props.Visible) == "function" then
			props.Visible(false)
		end
	end

	return create "Frame" {
		Name = props.Name or "Modal",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = animatedBackdropTransparency,
		Size = UDim2.fromScale(1, 1),
		Visible = visible,
		ZIndex = props.ZIndex or 50,

		create "Frame" {
			Name = "Dialog",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme.Colors.Surface,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = props.Size or UDim2.fromOffset(360, 240),
			ZIndex = (props.ZIndex or 50) + 1,

			create "UIScale" {
				Scale = animatedDialogScale,
			},

			create "UICorner" {
				CornerRadius = Theme.Radii.Panel,
			},

			create "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Colors.Border,
				Thickness = 1,
				Transparency = 0.1,
			},

			create "UIPadding" {
				PaddingBottom = UDim.new(0, 16),
				PaddingLeft = UDim.new(0, 16),
				PaddingRight = UDim.new(0, 16),
				PaddingTop = UDim.new(0, 16),
			},

			create "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Bold,
				Size = UDim2.new(1, -48, 0, 0),
				Text = props.Title or "Confirm",
				TextColor3 = Theme.Colors.Text,
				TextSize = 20,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = (props.ZIndex or 50) + 2,
			},

			IconButton {
				AnchorPoint = Vector2.new(1, 0),
				Icon = "X",
				Name = "CloseButton",
				OnActivated = close,
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.fromOffset(34, 34),
				ZIndex = (props.ZIndex or 50) + 2,
			},

			create "TextLabel" {
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Regular,
				Position = UDim2.fromOffset(0, 52),
				Size = UDim2.new(1, 0, 1, -114),
				Text = props.Body or "",
				TextColor3 = Theme.Colors.TextMuted,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				ZIndex = (props.ZIndex or 50) + 2,
			},

			create "Frame" {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 44),
				ZIndex = (props.ZIndex or 50) + 2,

				create "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},

				Button {
					LayoutOrder = 1,
					OnActivated = close,
					Size = UDim2.fromOffset(108, 40),
					Text = props.CancelText or "Cancel",
					Variant = "Secondary",
					ZIndex = (props.ZIndex or 50) + 3,
				},

				Button {
					LayoutOrder = 2,
					OnActivated = function()
						if props.OnConfirm then
							props.OnConfirm()
						end

						close()
					end,
					Size = UDim2.fromOffset(108, 40),
					Text = props.ConfirmText or "Confirm",
					Variant = props.ConfirmVariant or "Primary",
					ZIndex = (props.ZIndex or 50) + 3,
				},
			},
		},
	}
end
