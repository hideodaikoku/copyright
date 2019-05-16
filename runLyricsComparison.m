try
   %% FETCH SONG LYRICS
   % lyrics string array
   lyrics_array = {'A','B'};
   
   %% SETTING FOR STIMULI
   randStimuliNums = randperm(length(lyrics_array));
   % shuffle the pairs of stimuli
   stimuli_order = lyrics_array(randStimuliNums,:);
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
      
      fig = figure(1);
      fig.Color = [0.7 0.7 0.7];
      fig.MenuBar = 'none';
      fig.Units = 'normalized';
      maximize(fig);
      
      subplot(2,1,1);
      axis off;
      text(0.475,0.5,'A','fontsize',fontSize,'HorizontalAlignment','center','VerticalAlignment','middle');
      
      subplot(2,1,2);
      axis off;
      text(0.475,0.5,'B','fontsize',fontSize,'HorizontalAlignment','center','VerticalAlignment','middle');
      
      pause(15);
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
   
   participantData.LyricsComparison.stimuliOrder = stimuli_order;
   participantData.LyricsComparison.similarity = results_similarity;
   participantData.LyricsComparison.infringe = results_infringe;
catch
   ListenChar(0);
   ShowCursor;
end