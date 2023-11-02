%settings to use LCD
warning off MATLAB:DeprecatedLogicalAPI
Screen('Preference', 'SkipSyncTests', 1); 

%open a new screen with black back
[window,rect]=Screen('OpenWindow',2,0);

%get refresh interval
refresh=Screen('GetFlipInterval',window);  

%load the image and make texture
load durer;
durer=Screen('MakeTexture',window,X);

%put the blank screen up
vbl=Screen('Flip',window); %synchronizing to retrace.

%loop to rotate image
for i=1:36
    
    %draw rotates image
    Screen('DrawTexture',window,durer,[],[],10*i);
    
    %flip it after 3 refreshs
    vbl=Screen('Flip',window    , vbl + (3-0.5)*refresh,[],1);
end;

%wait for keypress
KbWait;

Screen('CloseAll');
