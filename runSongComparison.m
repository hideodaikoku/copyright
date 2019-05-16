try
   %% FETCH SONG NAMES
   % string array and directory for stimuli
   if ispc
      [songstr_full, music_dir_full] = scanFilesFromDir('.\Copyright_stimuli\Full');
      [songstr_melody, music_dir_melody] = scanFilesFromDir('.\Copyright_stimuli\Melody');
   elseif ismac
      [songstr_full, music_dir_full] = scanFilesFromDir('./Copyright_stimuli/Full');
      [songstr_melody, music_dir_melody] = scanFilesFromDir('./Copyright_stimuli/Melody');
   end
   
   %% SETTING FOR STIMULI
   % create stimuli pairs for full
   full_stimuli_pairs = createOrderedPairs(songstr_full);
   full_stimuli_pairs = horzcat(full_stimuli_pairs, num2cell(ones(length(full_stimuli_pairs),1)));
   % create stimuli pairs for melody
   melody_stimuli_pairs = createOrderedPairs(songstr_melody);
   melody_stimuli_pairs = horzcat(melody_stimuli_pairs, num2cell(ones(length(melody_stimuli_pairs),1)*2));
   % create stimuli pairs for full mix
   full_mixed_stimuli_pairs = createMixedPairs(songstr_full);
   full_mixed_stimuli_pairs = horzcat(full_mixed_stimuli_pairs, num2cell(ones(length(full_mixed_stimuli_pairs),1)*3));  
   % create stimuli pairs for melody mix
   melody_mixed_stimuli_pairs = createMixedPairs(songstr_melody);
   melody_mixed_stimuli_pairs = horzcat(melody_mixed_stimuli_pairs, num2cell(ones(length(melody_mixed_stimuli_pairs),1)*4));
   
   all_stimuli_pairs = [full_stimuli_pairs; melody_stimuli_pairs; full_mixed_stimuli_pairs; melody_mixed_stimuli_pairs];
   
   randStimuliNums = randperm(length(all_stimuli_pairs));
   % shuffle the pairs of stimuli
   stimuli_order = all_stimuli_pairs(randStimuliNums,:);
   % number of trials per block
   Ntrials = length(stimuli_order);
   
   % array of results
   results_similarity = zeros(Ntrials,1);
   results_infringe = zeros(Ntrials,1);
   
   %% START EXPERIMENT
   fig = figure(1);
   fig.MenuBar = 'none';
   fig.Units = 'normalized';
   maximize(fig);
   axis off;
   
   pause(3);
   
   f = msgbox(native2unicode('�����͂����ł���?'),'','warn');
   waitfor(f);
   close(fig);
   
   pause(1);
   
   for trial = 1:Ntrials
      % hide mouse cursor
      HideCursor;
      
      pause(1);
      
      % get WAV file name
      first_stimuli = stimuli_order(trial,1);
      second_stimuli = stimuli_order(trial,2);
      
      switch cell2mat(stimuli_order(trial,3))
         case {1,3}
            music_dir = music_dir_full;
         case {2,4}
            music_dir = music_dir_melody;
      end
      
      if ispc
         audioFileName1 = char(strcat(music_dir, '\', first_stimuli));
         audioFileName2 = char(strcat(music_dir, '\', second_stimuli));
      elseif ismac
         audioFileName1 = char(strcat(music_dir, '/', first_stimuli));
         audioFileName2 = char(strcat(music_dir, '/', second_stimuli));
      end
      
      [wavWave1, waveFs] = psychwavread(audioFileName1);
      [wavWave2, waveFs] = psychwavread(audioFileName2);
      wavdata1 = wavWave1';
      wavdata2 = wavWave2';
      
      fig = figure(1);
      fig.Color = [0.7 0.7 0.7];
      fig.MenuBar = 'none';
      fig.Units = 'normalized';
      maximize(fig);
      axis off;
      text(0.475,0.5,'A','fontsize',fontSize,'HorizontalAlignment','center','VerticalAlignment','middle');
      
      pause(1);
      
      PsychPortAudio('FillBuffer', pahandle, wavdata1);
      PsychPortAudio('Start', pahandle);
      PsychPortAudio('Stop', pahandle, 1);
      WaitSecs(1);
      
      clf;
      axis off;
      text(0.475,0.5,'B','fontsize',fontSize,'HorizontalAlignment','center','VerticalAlignment','middle');
      
      pause(1);
      
      PsychPortAudio('FillBuffer', pahandle, wavdata2);
      PsychPortAudio('Start', pahandle);
      PsychPortAudio('Stop', pahandle, 1);
      
      pause(1);
      close(1);
      
      ShowCursor;
      
      % save the current workspace to use the variables at gui
      current_randNum = randStimuliNums(trial);
      save('temporaryData.mat','current_randNum','results_similarity','results_infringe');
      
      % get the VAS scale result
      g = songcomparison_gui;
      waitfor(g);
      
      load('temporaryData1.mat','results_similarity','results_infringe');
      
      if mod(trial,14) == 0
         restTime;
      end
   end
   
   participantData.SongComparison.stimuliOrder = stimuli_order;
   participantData.SongComparison.similarity = results_similarity;
   participantData.SongComparison.infringe = results_infringe;
   
   PsychPortAudio('Close', pahandle);
catch
   ListenChar(0);
   ShowCursor;
   psychrethrow(psychlasterror);
   rethrow(errorStruct);
end