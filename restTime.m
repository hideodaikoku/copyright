fig = figure(1);
fig.MenuBar = 'none';
fig.Units = 'normalized';
% fig.OuterPosition = [0 0 1 1];
maximize(fig);

t = timer;
tic;
t.ExecutionMode = 'fixedDelay';
t.Period = 1;
t.StartDelay = 1;
t.TasksToExecute = 180; % seconds
t.TimerFcn = {@timerFile,windowHeight*0.1};
t.BusyMode = 'queue';
start(t);
wait(t);
close(1);
delete(t);