#include "umf.lua"

OptionsMenu {
    title = "Flamethrower",
	OptionsMenu.Text("thanks to the Precision Flight mod for inspiration for this options panel"),

    OptionsMenu.Spacer(50),

	OptionsMenu.Group {
		title = "Keybinds",

		OptionsMenu.Keybind { id = "key.nozzle_decrease", name = "Close nozzle", default = "i" },
		OptionsMenu.Keybind { id = "key.nozzle_increase", name = "Open nozzle", default = "o" },
	}
}
