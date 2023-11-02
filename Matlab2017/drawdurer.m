%settings to use LCD
warning off MATLAB:DeprecatedLogicalAPI
Screen('Preference', 'SkipSyncTests', 1); 

%open a new black window
[window,rect]=Screen('OpenWindow',2,0);

%load the image
load durer;

%start a timer

%make texture in memory
durer=Screen('MakeTexture',window,X);
t1=GetSecs;

%draw the texture to the window
Screen('DrawTexture',window,durer);

%flip to screen
Screen('Flip',window);
t2=GetSecs; 

%get the keypress
KbWait; 

%close the windows
Screen('CloseAll');

%comptue the time and print it
time2open=round((t2-t1)*1000);
fprintf('It took %d milliseconds to do so',time2open); 
