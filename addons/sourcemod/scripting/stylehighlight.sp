#include <shavit>
#include <sourcemod>

public Plugin myinfo =
{
    name        = "StyleHighlighter",
    author      = "MSWS",
    description = "Highlight Players by Style",
    version     = "0.0.1",
    url         = "https://github.com/MSWS"
};

public void Shavit_OnStyleChanged(int client, int old, int newStyle, int track, bool manual) {
    UpdateColor(client, newStyle);
}

public void OnClientPutInServer(int client) {
    UpdateColor(client);
}

public void Shavit_OnReplayStart(int entity, int tpe, bool elapsed) {
    UpdateColor(entity, _, true);
}

void UpdateColor(int client, int style = -1, bool bot = false) {
    if (style == -1)
        style = bot ? Shavit_GetReplayBotStyle(client) : Shavit_GetBhopStyle(client);
    char color[16];
    Shavit_GetStyleStrings(style, sHTMLColor, color, sizeof(color));
    int val = StringToInt(color, 16);

    int r = (val & 0xff0000) >> 16;
    int g = (val & 0x00ff00) >> 8;
    int b = (val & 0x0000ff);

    int unused, exAlph;
    GetEntityRenderColor(client, unused, unused, unused, exAlph);
    SetEntityRenderColor(client, r, g, b, exAlph);
}