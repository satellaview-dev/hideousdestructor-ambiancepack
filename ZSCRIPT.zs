version "4.14"
class RandomMusicPlayer : EventHandler
{
    string MusicSelection;

    override void OnRegister()
    {
        {
            ChangeMusicRandom();
        }
    }

    void ChangeMusicRandom()
    {
        if (!MusicSelection) MusicSelection = GetRandomMusicLump();
        if (MusicSelection)
        {
            console.printf("HDAP: Playing music: "..MusicSelection);
            S_ChangeMusic(MusicSelection);
        }
        else
        {
            console.printf("HDAP: No valid music lumps found.");
        }
    }

    string GetRandomMusicLump()
    {
        array<string> MusicList;

        int LevelInfosCount=levelinfo.GetLevelInfoCount();
        for (int i = 0; i < LevelInfosCount; i++)
        {
            levelinfo li = levelinfo.GetLevelInfo(i);
            string musicLump=li.music;

            // because of a quirk in how Doom/2 music is handled
            if (musicLump.left(1) == "$") musicLump="d_"..stringtable.localize(musicLump);

            if (MusicLump && wads.findlump(MusicLump) >= 0)
            {
                //console.printf("Music for level "..li.levelnum..": "..li.music.." = "..MusicLump);//debug
                MusicList.push(musicLump);
            }
        }

        if (MusicList.size() > 0)
        {
            return MusicList[random(0,MusicList.size() - 1)];
        }
        else
        {
            return "";
        }
    }
}
