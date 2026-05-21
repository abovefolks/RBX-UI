local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)


local derive = Vide.derive
local spring = Vide.spring

local Motion = {}

Motion.Duration = {
    Fast = 0.16,
    Normal = 0.2,
    Slow = 0.24,
}

Motion.Damping = {
    Smooth = 1,
    Snappy = 0.85,
    Soft = 0.9,
}

function Motion.tween(goal, duration, damping) 
    return spring(goal, duration or Motion.Duration.Normal, damping or Motion.Damping.Smooth)
end

function Motion.scale(goal, duration, damping)
    return spring(goal, duration or Motion.Duration.Fast, damping or Motion.Damping.Soft)
end

function Motion.hoverPressScale(hovered, pressed, disabled, hoverScale, pressScale)
    return Motion.scale(derive(function()
        if disabled and disabled() then
            return 1
        end

        if pressed() then
            return pressScale or 0.97
        end

        if hovered() then
            return hoverScale or 1.02
        end

        return 1

    end), Motion.Duration.Fast, Motion.Damping.Snappy)
end

function Motion.booleanScale(value, activeScale, inactiveScale, duration, damping)
    return Motion.scale(derive(function()
        return if value() then activeScale or 1 else inactiveScale or 0.92
    end), duration or Motion.Duration.Slow, damping or Motion.Damping.Snappy)
end

return Motion