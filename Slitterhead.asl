/*
*	Slitterhead Casualty Display v0.1
*	GitHub: https://github.com/roxasunbanned/slitterhead-casualty-display
*	Notes:
*       - Requires LiveSplit [https://github.com/LiveSplit/LiveSplit]
*       - Requires ASLVarViewer [https://github.com/hawkerm/LiveSplit.ASLVarViewer] and asl-help [https://github.com/just-ero/asl-help] added to /Components
*/

state("YKS-Win64-Shipping") {   
    int CurrentMissionCasualties: 0;
    int TotalCasualties: 0;
}

startup {
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
}

init {					
    IntPtr gEngine = vars.Helper.ScanRel(3, "48 89 05 ???????? 48 85 c9 74 ?? e8 ???????? 48 8d 4d");
    vars.Helper["LurkingParasite"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x44);
    vars.Helper["SleeplessZone"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x7C);
    vars.Helper["MissingGirl"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x98);
    vars.Helper["OpressiveForce"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0xD0);
    vars.Helper["HiddenCave"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x108);
    vars.Helper["MantisTrap"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x190);
    vars.Helper["MantisTrap_alt"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x174);
    vars.Helper["JarOfPoison"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x178);
    vars.Helper["JarOfPoison_alt"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x15C);
    vars.Helper["DriftingDevil"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x1AC);
    vars.Helper["BlackPayback"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x200);
    vars.Helper["GhostFamily"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x21C);
    vars.Helper["BindBreak"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x108, 0x38, 0xB8, 0x238);
    vars.Helper["CurrentMission"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x38, 0x0, 0x30, 0x348, 0x488, 0x358);
}
update {
    vars.Helper.Update();
    vars.Helper.MapPointers();
    int MantisTrap_checked = current.MantisTrap != -1 ? current.MantisTrap : current.MantisTrap_alt;
    int JarOfPoison_checked = current.JarOfPoison != -1 ? current.JarOfPoison : current.JarOfPoison_alt;
    current.CurrentMissionCasualties = current.CurrentMission > 0 ? current.CurrentMission : 0;
    current.TotalCasualties = current.LurkingParasite + current.SleeplessZone + current.MissingGirl + current.OpressiveForce + current.HiddenCave + MantisTrap_checked + JarOfPoison_checked + current.DriftingDevil + current.BlackPayback + current.GhostFamily + current.BindBreak;
    return true;
}