%these should be at the start of all your code on LCD monitors
warning off MATLAB:DeprecatedLogicalAPI
Screen('Preference', 'SkipSyncTests', 1); 

%This opens a new screen
[window,rect]=Screen('OpenWindow',2,0);

%compute how long of slack to use
slack=Screen('GetFlipInterval',window)/2;

%set the text options
Screen('TextFont',window,'Times New Roman');
Screen('TextSize',window,40); 

%draws some text to the buffer
[newX, newY]=Screen('DrawText',window,'Hello ', 100,100,[ 255 0 0]);
Screen('Flip',window,[], 1);%don’t erase Hello!
t1=GetSecs;

%draw more text to buffer
Screen('DrawText',window,'World ',newX,newY,[ 255 0 0]);
Screen('Flip',window, t1 + 0.500 - slack);
t2=GetSecs;

%wait for a keypress
KbWait;

%close all windows
Screen('CloseAll');

%check the time to open and flip and print
time2open=round((t2-t1)*1000);
fprintf('It took %d milliseconds to do so', time2open); 
