local Theme = {}

Theme.Colors = {
    Background = Color3.fromRGB(22, 22, 22),
	Surface = Color3.fromRGB(17, 17, 17),
	SurfaceRaised = Color3.fromRGB(58, 58, 58),
	SurfaceMuted = Color3.fromRGB(70, 70, 70),
	Border = Color3.fromRGB(72, 72, 72),
	Text = Color3.fromRGB(245, 248, 255),
	TextMuted = Color3.fromRGB(169, 179, 196),
	Accent = Color3.fromRGB(190, 190, 190),
	AccentHover = Color3.fromRGB(210, 210, 210),
	AccentPressed = Color3.fromRGB(140, 140, 140),
	Danger = Color3.fromRGB(232, 95, 99),
	DangerHover = Color3.fromRGB(247, 118, 122),
	DangerPressed = Color3.fromRGB(195, 73, 78),
}

Theme.Buttons = {
	Primary = {
		Background = Theme.Colors.Accent,
		Hover = Theme.Colors.AccentHover,
		Pressed = Theme.Colors.AccentPressed,
		Stroke = Color3.fromRGB(230, 230, 230),
		Text = Color3.fromRGB(18, 18, 18),
	},
	Secondary = {
		Background = Theme.Colors.SurfaceRaised,
		Hover = Color3.fromRGB(72, 72, 72),
		Pressed = Color3.fromRGB(45, 45, 45),
		Stroke = Theme.Colors.Border,
		Text = Theme.Colors.Text,
	},
	Danger = {
		Background = Theme.Colors.Danger,
		Hover = Theme.Colors.DangerHover,
		Pressed = Theme.Colors.DangerPressed,
		Stroke = Color3.fromRGB(255, 160, 164),
		Text = Color3.fromRGB(31, 8, 10),
	},
}

Theme.Fonts = {
	Regular = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular),
	Medium = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
	Semibold = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
	Bold = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
}

Theme.Radii = {
	Panel = UDim.new(0, 12),
	Control = UDim.new(0, 8),
}

return Theme