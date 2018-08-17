package android

// Global config used by Potato soong additions
var PotatoConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.potato.hardware",
	},
}
