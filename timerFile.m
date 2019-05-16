function timerFile(obj, event, fontSize)
tnow = toc;
tnow = round(tnow);
tnow_minute = floor(tnow/60);
tnow_second = floor(rem(tnow,60));
leftTime = duration(0,3,0,'Format','mm:ss') - duration(0,tnow_minute,tnow_second);
clf;
axis off;

take_rest = native2unicode('‹xŒe‚ð‚Æ‚Á‚Ä‚­‚¾‚³‚¢');
time_left = native2unicode('Žc‚èŽžŠÔ');

% take a break
text(0.5,0.9,take_rest,'FontSize',fontSize,'HorizontalAlignment','Center','VerticalAlignment','Middle');
% time left
text(0.5,0.7,time_left,'FontSize',fontSize*0.4,'HorizontalAlignment','Center','VerticalAlignment','Middle');
text(0.5,0.5,[char(leftTime)],'FontSize',fontSize,'HorizontalAlignment','Center','VerticalAlignment','Middle');