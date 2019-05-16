beep off;
close all;
clear all;
%% make directory and IDname
% get the input
input_result = input('ENTER PARTICIPANT ID: ', 's');
% get the ID
namestr = input_result;

this_directory = dir('headCopyright.m');

if ispc
  save_dir = char(strcat(this_directory.folder,'\data\'));
elseif ismac
  save_dir = char(strcat(this_directory.folder,'/data/'));
end
% if save directory does not exist, make it
if not(exist(save_dir))
  mkdir(save_dir)
end

%% SETTING FOR EXPERIMENT
% get window size
[windowWidth,windowHeight] = Screen('WindowSize',0);
fontSize = windowHeight*0.1;
% number of channels
nrchannels = 2;

%% SETTING FOR PSYCHTOOLBOX
% keyboard unable
ListenChar(2);
AssertOpenGL;
% keyboard unicode
KbName('UnifyKeyNames');
rng('shuffle');
InitializePsychSound

try
   pahandle = PsychPortAudio('Open', [], [], 0, 44100, nrchannels);
   disp('get pahandle');
catch
   psychlasterror('reset');
   pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
end

%% RUN EXPERIMENT IN ORDER
expDate = datestr(now,'mmdd_HHMM');
participantData = struct();
participantData.name = namestr;
participantData.expDate = expDate;

% run Comparison of Songs
runSongComparison;

fileName = [namestr,'_',expDate];
save([save_dir,fileName],'participantData');
delete temporaryData.mat temporaryData1.mat

% run Comparison of Lyrics
% runLyricComparison;
% 
% fileName = [namestr,'_',expDate];
% save([save_dir,fileName],'participantData');
% delete temporaryData.mat temporaryData1.mat

fig = figure(1);
fig.MenuBar = 'none';
fig.Units = 'normalized';
maximize(fig);
axis off;

f = msgbox(native2unicode('�����l�ł�'));
waitfor(f);

ListenChar(0);
