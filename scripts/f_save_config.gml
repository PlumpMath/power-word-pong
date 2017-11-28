ini_open("prefs.ini");
ini_write_real("Preferences", "ai0", global.ai[0]);
ini_write_real("Preferences", "ai1", global.ai[1]);
ini_write_real("Preferences", "sfx", global.sfx);
ini_write_real("Preferences", "music", global.music);
ini_close();
