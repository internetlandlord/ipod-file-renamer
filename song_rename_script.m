%MUST MOVE TO DIRECTORY WITH SONGS!
%make a struct of directory '*.mp3'
songList = dir('*m4a');
songListDimensions = size(songList);
songListLimit = songListDimensions(1);

for i = 1: 1: songListLimit;
    
    %Assemble the song file path to pass to extraction portion
    songAddr = strcat(songList(i).folder, '\' ,songList(i).name);
    disp(songAddr);
    
    %Extract the metadata of the song and organize subcomponents
    songInfo = audioinfo(songAddr);
    songTitle = lower(songInfo.Title);
    songFormat = lower(songInfo.CompressionMethod);
    
    %Replace whitespaces with underscores 
    oldSpaces = find(songTitle == ' ');
    songTitle(oldSpaces) = '_';
    oldSpaces = find(songTitle == '/');
    songTitle(oldSpaces) = '_';
        
    %Cycle through unacceptable string characters and delete them
    %FIXME: Inefficient
    badSpaces = find(songTitle == '.');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == '(');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == ')');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == '[');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == ']');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == '?');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == '"');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == '''');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == ',');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == ':');
    songTitle(badSpaces) = '';
    badSpaces = find(songTitle == '*');
    songTitle(badSpaces) = '';
    
    
    
    %Assemble the subcompents into new filename
    newSongFileName = strcat(songTitle, '.', songFormat);
    %dirSongAddr = strcat('.\', songList(i).name);
    dirSongAddr = songList(i).name;
    
    %Rename file with new name
    %FIXME: need to make sure it ignores files with no title metadata
    flag = isequal(lower(dirSongAddr), newSongFileName);
    if (flag == 0)
        movefile(dirSongAddr, newSongFileName);
    end
    
    %Log it to console
    disp(newSongFileName);
   
end
