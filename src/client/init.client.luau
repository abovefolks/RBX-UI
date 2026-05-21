local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Vide = require(ReplicatedStorage.Packages.Vide)
local UI = require(ReplicatedStorage.Components)

local create = Vide.create
local source = Vide.source
local derive = Vide.derive

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local toggleValue = source(false)
local sliderValue = source(50)
local progressValue = source(0)
local selectedCard = source(nil)

spawn(function()
	while true do
		task.wait(0.05)
		progressValue(math.min(progressValue() + 1, 100))
		if progressValue() >= 100 then
			progressValue(0)
		end
	end
end)

Vide.root(function()
	local screenGui = create "ScreenGui" {
		Name = "RBX UI Demo",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		Enabled = true,

		create "Frame" {
			Name = "MainContainer",
			BackgroundColor3 = UI.Theme.Colors.Background,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),

			create "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 12),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			create "UIPadding" {
				PaddingBottom = UDim.new(0, 20),
				PaddingLeft = UDim.new(0, 20),
				PaddingRight = UDim.new(0, 20),
				PaddingTop = UDim.new(0, 20),
			},

			create "TextLabel" {
				Name = "Title",
				BackgroundTransparency = 1,
				FontFace = UI.Theme.Fonts.Bold,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 40),
				Text = "🎨 RBX UI Component Library Demo",
				TextColor3 = UI.Theme.Colors.Text,
				TextSize = 28,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			create "TextLabel" {
				Name = "Subtitle",
				BackgroundTransparency = 1,
				FontFace = UI.Theme.Fonts.Regular,
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0, 20),
				Text = "Built with Vide - Reusable UI Components for Roblox",
				TextColor3 = UI.Theme.Colors.TextMuted,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			create "Frame" {
				BackgroundColor3 = UI.Theme.Colors.Border,
				BorderSizePixel = 0,
				LayoutOrder = 3,
				Size = UDim2.new(1, 0, 0, 1),
			},

			create "TextLabel" {
				BackgroundTransparency = 1,
				FontFace = UI.Theme.Fonts.Semibold,
				LayoutOrder = 4,
				Size = UDim2.new(1, 0, 0, 24),
				Text = "Buttons",
				TextColor3 = UI.Theme.Colors.Text,
				TextSize = 18,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			create "Frame" {
				BackgroundTransparency = 1,
				LayoutOrder = 5,
				Size = UDim2.new(1, 0, 0, 50),

				create "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 12),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},

				UI.Button({
					Name = "PrimaryBtn",
					Text = "Primary",
					Variant = "Primary",
					LayoutOrder = 1,
					Size = UDim2.fromOffset(140, 44),
					OnActivated = function()
						print("✅ Primary button clicked!")
					end,
				}),

				UI.Button({
					Name = "SecondaryBtn",
					Text = "Secondary",
					Variant = "Secondary",
					LayoutOrder = 2,
					Size = UDim2.fromOffset(140, 44),
					OnActivated = function()
						print("✅ Secondary button clicked!")
					end,
				}),

				UI.Button({
					Name = "DangerBtn",
					Text = "Danger",
					Variant = "Danger",
					LayoutOrder = 3,
					Size = UDim2.fromOffset(140, 44),
					OnActivated = function()
						print("✅ Danger button clicked!")
					end,
				}),

				UI.Button({
					Name = "DisabledBtn",
					Text = "Disabled",
					Disabled = true,
					LayoutOrder = 4,
					Size = UDim2.fromOffset(140, 44),
					OnActivated = function()
						print("Button disabled")
					end,
				}),
			},

			create "TextLabel" {
				BackgroundTransparency = 1,
				FontFace = UI.Theme.Fonts.Semibold,
				LayoutOrder = 6,
				Size = UDim2.new(1, 0, 0, 24),
				Text = "Toggle",
				TextColor3 = UI.Theme.Colors.Text,
				TextSize = 18,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			UI.Toggle({
				Name = "DemoToggle",
				Label = "Enable Feature",
				Value = toggleValue,
				LayoutOrder = 7,
				OnChanged = function(value)
					print("🔘 Toggle changed to:", value)
				end,
			}),

			create "TextLabel" {
				BackgroundTransparency = 1,
				FontFace = UI.Theme.Fonts.Semibold,
				LayoutOrder = 8,
				Size = UDim2.new(1, 0, 0, 24),
				Text = "Slider",
				TextColor3 = UI.Theme.Colors.Text,
				TextSize = 18,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			UI.Slider({
				Name = "DemoSlider",
				Min = 0,
				Max = 100,
				Value = sliderValue,
				Step = 1,
				LayoutOrder = 9,
				OnChanged = function(value)
					print("🎚️ Slider value:", math.round(value))
				end,
			}),

			create "TextLabel" {
				BackgroundTransparency = 1,
				FontFace = UI.Theme.Fonts.Semibold,
				LayoutOrder = 10,
				Size = UDim2.new(1, 0, 0, 24),
				Text = "Progress Bar",
				TextColor3 = UI.Theme.Colors.Text,
				TextSize = 18,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			UI.ProgressBar({
				Name = "DemoProgress",
				Value = progressValue,
				Min = 0,
				Max = 100,
				LayoutOrder = 11,
			}),

			create "TextLabel" {
				BackgroundTransparency = 1,
				FontFace = UI.Theme.Fonts.Semibold,
				LayoutOrder = 12,
				Size = UDim2.new(1, 0, 0, 24),
				Text = "Cards",
				TextColor3 = UI.Theme.Colors.Text,
				TextSize = 18,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			create "Frame" {
				BackgroundTransparency = 1,
				LayoutOrder = 13,
				Size = UDim2.new(1, 0, 0, 220),

				create "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, 12),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},

				UI.Card({
					Name = "Card1",
					Title = "🎯 Component Library",
					Description = "A comprehensive collection of reusable UI components built with Vide for Roblox games.",
					Size = UDim2.new(1, 0, 0, 100),
					LayoutOrder = 1,
					Selected = derive(function()
						return selectedCard() == 1
					end),
					OnActivated = function()
						selectedCard(1)
						print("📌 Card 1 selected")
					end,
				}),

				UI.Card({
					Name = "Card2",
					Title = "⚡ Reactive UI",
					Description = "Built with Vide for reactive and declarative UI development with smooth animations.",
					Size = UDim2.new(1, 0, 0, 100),
					LayoutOrder = 2,
					Selected = derive(function()
						return selectedCard() == 2
					end),
					OnActivated = function()
						selectedCard(2)
						print("📌 Card 2 selected")
					end,
				}),
			},

			create "Frame" {
				BackgroundColor3 = UI.Theme.Colors.SurfaceRaised,
				BorderSizePixel = 0,
				LayoutOrder = 14,
				Size = UDim2.new(1, 0, 0, 120),

				create "UICorner" {
					CornerRadius = UI.Theme.Radii.Panel,
				},

				create "UIListLayout" {
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},

				create "UIPadding" {
					PaddingBottom = UDim.new(0, 12),
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 12),
				},

				create "TextLabel" {
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = UI.Theme.Fonts.Semibold,
					LayoutOrder = 1,
					Size = UDim2.fromScale(1, 0),
					Text = "📚 State Values",
					TextColor3 = UI.Theme.Colors.Text,
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextWrapped = true,
				},

				create "TextLabel" {
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = UI.Theme.Fonts.Regular,
					LayoutOrder = 2,
					Size = UDim2.fromScale(1, 0),
					Text = derive(function()
						return string.format(
							"Toggle: %s | Slider: %d | Progress: %d%% | Selected Card: %s",
							tostring(toggleValue()),
							math.round(sliderValue()),
							math.round(progressValue()),
							selectedCard() or "None"
						)
					end),
					TextColor3 = UI.Theme.Colors.TextMuted,
					TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextWrapped = true,
				},
			},
		},
	}

	screenGui.Parent = playerGui
end)

print("✅ RBX UI Component Library Demo loaded!")
print("📖 Check the Output for interaction logs")
