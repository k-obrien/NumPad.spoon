--- === NumPad ===
---
--- Simulated number pad for macOS powered by Hammerspoon's hotkey API.
---
--- Download: [https://github.com/k-obrien/NumPad.spoon/archive/master.zip](https://github.com/k-obrien/NumPad.spoon/archive/master.zip)

local obj={}
obj.__index = obj

-- Metadata
obj.name = "NumPad"
obj.version = "0.1"
obj.author = "Kieran O'Brien"
obj.homepage = "https://github.com/k-obrien/NumPad.Spoon"
obj.license = "GPLv3 - https://opensource.org/licenses/GPL-3.0"

--- NumPad:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for NumPad
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for the following items:
---   * numLock - Enter/exit modal number pad state
---   * enter - Confirm input
---   * clear - Clear input
---   * zero - Type the numeral 0
---   * one - Type the numeral 1
---   * two - Type the numeral 2
---   * three - Type the numeral 3
---   * four - Type the numeral 4
---   * five - Type the numeral 5
---   * six - Type the numeral 6
---   * seven - Type the numeral 7
---   * eight - Type the numeral 8
---   * nine - Type the numeral 9
---   * decimal - Type the symbol for a decimal point
---   * division - Type the symbol for addition
---   * multiplication - Type the symbol for addition
---   * substraction - Type the symbol for subtraction
---   * addition - Type the symbol for addition
function obj:bindHotKeys(map)
	self.modal = hs.hotkey.modal.new()
	hs.spoons.bindHotkeysToSpec({ numLock = function () self.modal:enter() end }, { numLock = map.numLock })

	local partial = hs.fnutils.partial
	local keyStroke = hs.eventtap.keyStroke
	local keyCodes = hs.keycodes.map
	local def = {
		numLock = function () self.modal:exit() end,
		enter = partial(keyStroke, nil, keyCodes["padenter"]),
		clear = partial(keyStroke, nil, keyCodes["padclear"]),
		zero = partial(keyStroke, nil, keyCodes["pad0"]),
		one = partial(keyStroke, nil, keyCodes["pad1"]),
		two = partial(keyStroke, nil, keyCodes["pad2"]),
		three = partial(keyStroke, nil, keyCodes["pad3"]),
		four = partial(keyStroke, nil, keyCodes["pad4"]),
		five = partial(keyStroke, nil, keyCodes["pad5"]),
		six = partial(keyStroke, nil, keyCodes["pad6"]),
		seven = partial(keyStroke, nil, keyCodes["pad7"]),
		eight = partial(keyStroke, nil, keyCodes["pad8"]),
		nine = partial(keyStroke, nil, keyCodes["pad9"]),
		decimal = partial(keyStroke, nil, keyCodes["."]),
		division = partial(keyStroke, nil, keyCodes["pad/"]),
		multiplication = partial(keyStroke, nil, keyCodes["pad*"]),
		substraction = partial(keyStroke, nil, keyCodes["pad-"]),
		addition = partial(keyStroke, nil, keyCodes["pad+"])
	}

	for name, keySpec in pairs(map) do
		local keyDef = def[name]

		if keyDef then
			if #keySpec == 1 then table.insert(keySpec, 1, nil) end
			self.modal:bind(keySpec[1], keySpec[2], keyDef)
		end
	end
end

return obj
