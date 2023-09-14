clear all; 
currentDateTimeStr = datestr(now,'yyyymmdd_HHMM','local');
rootPath = 'C:\Users\q183cs\Videos\Setd5_Cul3_Air_2022-11-23' %insert path of the videos

folderList = getFileList(rootPath,'4|3'); %get all the folders from the different recordings
cellfun(@disp,folderList) %display them to see if all are there
nFolders = length(folderList);

%% runs through the folders looking for movies with 'part' in their
%fileexpression, then loads them, then MERGES them (one by one), as well
%as saves the new movie into the respective folders

for folderNo = 1:nFolders 
    disp('==================')
    folderName = folderList{folderNo};
    fprintf('Folder %d/%d: %s\n',folderNo,nFolders,folderName)
    g1 = getFileList(folderName,'|part1|');
    g2 = getFileList(folderName,'|part2|');
    %g3 = getFileList(folderName,'|part3|');

   vid1 = VideoReader(string(g1));
   vid2 = VideoReader(string(g2));
   %vid3 = VideoReader(string(g3));

   %gets folder number to name the file MouseNo_MergedVideo
   listing = dir(rootPath)
   MouseNo = listing(2+folderNo).name
   a = strcat(string(MouseNo),'_MergedVideo')
   a = char(a);

   %v = VideoWriter([folderName filesep a],'MPEG-4'); % Create new video file
   v = VideoWriter([folderName filesep a]); % Create new video file
   open(v)
   %% Iterate on all frames in video 1 and write one frame at a time
    tic
    while hasFrame(vid1) 
    Video1 = readFrame(vid1); % read each frame
    writeVideo(v,Video1) % write each frame
    end
    % Iterate again in video 2
    while hasFrame(vid2) 
    Video2 = readFrame(vid2); % read each frame
    writeVideo(v,Video2) % write each frame
    end
%     % Iterate again in video 3
%     while hasFrame(vid3)
%     Video3 = readFrame(vid3);
%     writeVideo(v,Video3)
%     end
    close(v)
    toc
end

