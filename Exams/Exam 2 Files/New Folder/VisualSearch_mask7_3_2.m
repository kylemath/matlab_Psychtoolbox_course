%-------------------------------------------------------------
%   7.3 make the mask only cover half the images
%Change 1: added 'mask' to the DATA structure (line 109)
%Change 2: make a variable 'masking' and randomize in 'mask' whether the mask happens( line 142-149)
%Change 3: if the mask is present, make the offtime shorter to compensate for
%the mask time (lines 162-167). (also commented out offtime definition at
%line 92)
%Change 4: if mask = 1 for this trial, show the mask
       %%texture (line 227-229)
%Change 5: if mask = 1 for this trial, show the mask
       %%texture (line 242-244)   

     
       %CHANGE TIMING

%   distractors and targets: line 16
%   L oriented four ways: function ell
%   T oriented four ways: function tee
%
%   v2.0 -- (03/03/05) Alejandro Lleras & William Horrey
%   Last Updated November 30, 2005
%-------------------------------------------------------------
%%1. Get subject number and decide whether to do the short or long version
SbjID = input('Enter Subject Number:   ');
Prac = input('Practice (y/n):','s');

%--------------------------------------------
%	Initialization
%--------------------------------------------
%2. Initialize: 
%Reset the random number generator 
% set the keynames for the computer
% set some global variables so that they can be used both in this
% experiment and in the separate functions
   	rand('state',sum(100*clock));
%     warning off MATLAB:DeprecatedLogicalAPI	  
    KbName('UnifyKeyNames');
    %@@ comment out the previous line to run on Macs
    Screen('Preference', 'SkipSyncTests', 1);   %For debugging on computers not optimized for PTB. Comment out for experiment
    global Xcentre;
    global Ycentre;
    global cx;
    global cy;
      
    
    %% Reserving memory space for big variables
    
    %3. Set up variables: background colours, colours (white, black, grey),
    %set offset & jitter, set-size, response keys, durations and trial
    %numbers. 
    
    background=[255 255 255];
    [window,rect]=Screen('OpenWindow',max(Screen('Screens')),background);
     %  [window,rect]=Screen('OpenWindow',max(Screen('Screens')),background, [0 0 600 400]);

    %creating a white background for a texture;
    white_background=zeros(rect(4),rect(3),3);
    white_background(:,:,1)=255;
    white_background(:,:,2)=255;
    white_background(:,:,3)=255;
    
    black_background=zeros(rect(4),rect(3),3);
    black_background(:,:,1)=0;
    black_background(:,:,2)=0;
    black_background(:,:,3)=0;
      
    %Sizes and colors   
    XLeft=rect(RectLeft);	XRight=rect(RectRight);
	YTop=rect(RectTop);		YBottom=rect(RectBottom);
	Xcentre=XRight./2; 		Ycentre=YBottom./2;
    
	white=[255,255,255];
	black=[0,0,0];
	grey=(white+black)/2;  
    
    offset=15;
    jitter=20;
    
    setsize=[16,32];
    color=[1,2];

    %response keys
   	escKey=KbName('q');
	LeftKey=KbName('x');
    RightKey=KbName(',<');
    
    %Durations
    refresh_rate=60;  %change to 60 on slow displays
    ontime=round(refresh_rate/10);  %100 ms
     gotime=round(refresh_rate/10);  %100 ms

  %  offtime=refresh_rate-2*ontime; %800 ms  %**This changed
    endtime=10; %time in seconds until end of trial
    Screentime=round(refresh_rate/2); %500 ms,
    totaltime=round(refresh_rate*endtime);
    ITI=fix(refresh_rate*3/2);
    fixtime=fix(refresh_rate/2);
        
    T_TRIALS=64;
    P_TRIALS=10;  %20    
    
        
%--------------------------------------------
%	Design
%--------------------------------------------    
%4. a)Set up a data structure 'DATA', of all ones and copy this into another 
%structure called 'Dummy'. 
%Change 1: added 'mask' to the DATA structure (line 109)
    DATA=repmat(struct('setsize',1,'tid',1,'rt',-1,'resp',-1,'error',-1, 'mask',1),...
        1,T_TRIALS);
      % setsize 16, 32
	  % Target identity x:blue T, ,:red
      % RT
	  % response 1:'z' key, 2:'/' key
      % error 0:correct, 1:error
    DUMMY=DATA;   
%b) change the numbers in dummy so that the setsize is either 16 or 32, 
%and so that tid or target identity is either 1 or 2. 
    for i=1:T_TRIALS
        DUMMY(i).setsize=setsize(fix((i-1)/(T_TRIALS/numel(setsize)))+1);
        DUMMY(i).tid=mod(i,2)+1;     %tid = target id,  codes target color        
    end;
%c) mix up the sequence and put it back into 'DATA'. Then name the trials
%1-60 and clear the dummy structure 'DUMMY'
	seq=randperm(T_TRIALS);
    DATA=DUMMY(seq);
	for n=1:T_TRIALS
		DATA(n).trial=n;    
    end;
    clear DUMMY;    

%d) change the trial number (number of trials called; T_TRIALS) to a lower
%number (10) if the person specified 'y' when asked if this was a practice.
%Also make a variable called endtrial which is equal to the number of
%trials.
    % configure practice block
    if (strcmp(Prac,'y'))
		T_TRIALS=P_TRIALS;
    end;
 %added this---- Change 2: make a variable 'masking' and randomize in 'mask' whether the mask happens( line 142-149)
masking(1,1:(T_TRIALS/2)) = 1
 masking(1,(T_TRIALS+1)/2: T_TRIALS) = 0
 masking = masking(randperm(length(masking)))

 for i = 1:T_TRIALS
DATA(i).mask = masking(i)
 end 
    endtrial=T_TRIALS;
   %added this-----------
 
   
%--------------------------------------------
%	Run Trials
%--------------------------------------------    
%5. a) Hide the cursor, create a for-loop going through all of the trials from 1-T_TRIALS. 
%Make the fixation cross & define 'search'
HideCursor;    
    
    for itrial=1:T_TRIALS
%Change 3: if the Mask ia present, make the offtime shorter to compensate for
%the mask time (lines 162-166).
      if DATA(itrial).mask == 1   
        offtime=refresh_rate-2*ontime; %800 ms 
      else
        offtime=refresh_rate-ontime; %900 ms
      end
      %-------%Draw trial contingent Screens
        search=Screen('MakeTexture',window,white_background);
        Screen('DrawLine',search,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
        Screen('DrawLine',search,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
    % added this to make the mask    
         masker=Screen('MakeTexture',window, white_background);
        Screen('DrawLine',masker,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
        Screen('DrawLine',masker,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
        % b)set up search grid: this randomizes all the colors and location
        % of the stimuli to be viewed for the trial 
        ssm1=DATA(itrial).setsize-1; %line 166
        locd=zeros(1,36);  
        %locd is passing variable for randomizing item locations in grid
      %set everythign in locd to zero. then go through the set size (-1; ssm1), and 
      %set everything to 1, then for locd(i+1) = 2 (i is the final number in the
      %loop).  
        for i=1:ssm1
            locd(i)=1;
        end;
        locd(i+1)=2;
        %make iloc a random permuation of 1 through the number of elements
        %in locd. then name a variable loc, which is a random permutation
        %of all the numbers in locd
        iloc=randperm(numel(locd));
        for i=1:36
        	loc(i)=locd(iloc(i));    
        end;
   % determine distractor colors and randomize them into mixcol. 
        % determine distractor colors
        distcol = DATA(itrial).tid * ones(1,ssm1);  
        for n=1:(ceil(ssm1/2))
            distcol(n)=3-DATA(itrial).tid;    
        end;
        
        mixcol=randperm(ssm1);
     %then put the colors into a variable called colour, the size of the setsize -1.    
        for n=1:ssm1
        	colour(n)=distcol(mixcol(n));    
        end;        
        
        n=1;
        % populate grid with distractors and target
        
        % b) make the distractor and target stimuli and put them into 2
        % functions: ell (distractors) and tee(targets). then clear the
        % variables that you used to make these. 
        % goes through the for-loop and decides what to put (target or
        % distractor) in each space on the grid, according to the number
        % found in loc(i). the tee and ell functions make the targets and
        % distractors on the specified place on the grid. 
        for i=1:36
            if loc(i)==1   %1 is for distractors
                grid(i); %location on the search grid. 
                tempcol=colour(n); %pick random color
                tempor=fix(rand(1)*4)+1; %pick a random number and round towards zero-> defines orientation
                tempx=cx+(round(rand(1)*jitter))+ offset; % define a random spot of x (within the current grid location)
                tempy=cy+(round(rand(1)*jitter))+ offset; % define a random spot of y (within the current grid location)
                ell(search,tempcol,tempor,tempx,tempy); %place an L on the 'search' grid, using the colour, orientation, %and x and y coordinates (of the top left corner) just defined.
       %%added ------- Change 4: if mask = 1 for this trial, show the mask
       %%texture (line 227-229)
                if DATA(itrial).mask == 1  
                mask(masker, tempx, tempy) %%added the mask here!!
                end    
        %%added ---------------------------------------

      n=n+1;
            elseif loc(i)==2 %2 is for target
                grid(i); %location on the search grid. 
                tempor=fix(rand(1)*4)+1; %pick a random number and round towards zero-> defines orientation
                tempx=cx+(round(rand(1)*jitter))+ offset; % define a random spot of x (within the current grid location)
                tempy=cy+(round(rand(1)*jitter))+ offset; % define a random spot of y (within the current grid location)
                tee(search,DATA(itrial).tid,tempor,tempx,tempy); %place a T on the 'search' grid, using the colour, orientation, 
  %              and x and y coordinates (of the top left corner) just defined. 
       %%added ---- Change 5: if mask = 1 for this trial, show the mask
       %%texture (line 242-244)
                if DATA(itrial).mask == 1    
                mask(masker, tempx, tempy) %%added the mask here!!
                end    
        %%added ---------------------------------------
            end;
            
             
            clear tempx;
            clear tempy;
            clear tempor;
            clear tempcol;
        end;
        
        %getchar;
% end the trial if the keyboard is pressed. 
        while KbCheck;end; % wait until all keys are released.
        
 
      %6. Start the search task:           
  %%%%%%% start search task
     %fixation cross   
      s=0;
        Screen('DrawLine',window,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
        Screen('DrawLine',window,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
        Screen('Flip',window,[],1);
        %a)for 30 frames, show the fixation cross
        %flip the window. not clearing the frame so the cross is visible 
        %for this whole time. 
        for ff=1:fixtime
            Screen('Flip',window,[],1);
        end;
        
        
       
        %b)start RT
        %%
	  t1=GetSecs;
        %totaltime = 600
        %while the keyboard has not been pressed and we have used less than
        %600 frames(s), 
        
        %rally between the blank screen + fixation cross and the visual
        %search grid until either the user has pressed the keyboard or 600
        %frames have passed.
        %c) start the trial: while the keyboard has not been pressed and
        %there have been less than 600 frames in this trial, go back and
        %forth betweent the search screen (5 frames) and the fixation cross
        %screen (54 frames). Stop after 600 frames or when the user
        %responds wiith a button press. 
	  while ~KbCheck & (s < totaltime),
            c=0;
          %draw the search stimuli (target and distractors in texture)
          %while the c< ontime, meaning for 5 frames. 
        %the texture is drawtexture. 
            while ~KbCheck & (c < ontime),       
                  %Screen('Flip',window);
                  Screen('DrawTexture',window,search,[],[]);
                  Screen('Flip',window);
                c=c+1;
                s=s+1;
            end;
  %%-------------Added this next part to make the mask--------------------    
            c=0;
             while ~KbCheck & (c < gotime),       
                  %Screen('Flip',window);
                  Screen('DrawTexture',window,masker,[],[]);
                  Screen('Flip',window);
                c=c+1;
                s=s+1;
            end;
 %%-----------------------------------------------------------------------    

            c=0;
           %draw the fixation cross for the next 54 frames, between the task.   
            while ~KbCheck & (c < offtime),
                %Screen('Flip',window);
                Screen('DrawLine',window,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
                Screen('DrawLine',window,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
                Screen('Flip',window);
                c=c+1;
                s=s+1;
            end;    
        end;
        %d)Get information from keyboard press: reaction time, keycode, and
        %touch. 
        
        [touch, secs, keyCode] = KbCheck;
        %%
	    DATA(itrial).rt=(secs-t1)*1000;
%e) clear the screen for the next trial. 
                Screen('Flip',window,1);
                Screen('DrawLine',window,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
                Screen('DrawLine',window,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
                Screen('Flip',window);
                c=c+1;              
  %7.  A) classify responses: if the left key was pressed, and target ID (tid) is 1, mark the response as 1, and error = 0
  % e.g. they got it right. if tid is not 1, they got it wrong so mark
  % error = 1 and beep. same thing for the rightkey press, except with tid
  % and resp ==2. If no key is pressed, record resp = 3, error = 1 and
  % beep. 
 %%%%%%Classify responses
        if keyCode(LeftKey)
            if(DATA(itrial).tid==1)
                DATA(itrial).resp=1;
                DATA(itrial).error=0;
            else
                DATA(itrial).resp=1;
                DATA(itrial).error=1;
                if (strcmp(Prac,'y'))
                    beep;
                end;
                
            end;
            %break;
        elseif keyCode(RightKey)
            if(DATA(itrial).tid==2)
               DATA(itrial).resp=2;
               DATA(itrial).error=0;
            else
               DATA(itrial).resp=2;
               DATA(itrial).error=1;
               if (strcmp(Prac,'y'))
                    beep;
               end;
            end;
            %break;
        else
            DATA(itrial).resp=3;
            DATA(itrial).error=1;
            beep;
        end;
        
        if keyCode(escKey)
            fprintf('ESC\n');
            Screen('CloseAll');
            endtrial=itrial;
            break;
        end;
      %b)Print out the current response data and close the current 'search' screen. 
      %make a new blank screen. 
        fprintf('+  %4.1f   %2d   %2d\n', DATA(itrial).rt,...
            DATA(itrial).resp,DATA(itrial).error);
  
        
        Screen('Close',search);
        
        while KbCheck;end; % wait until key is released. 
        Screen('FillRect', window,[255 255 255]); 
        Screen('Flip', window);
        for ff=1:ITI
            Screen('Flip',window);        
        end;
    end;
    %getchar;
    %c) when all the trials are done, close the screen.
    Screen('CloseAll');
    
%--------------------------------------------
%	Output File
%--------------------------------------------  
	% open data file
    
    %8. make a data file with thefollowing variables: Subject,
    %Trial,ss,tid, RT, resp, Error. Then close the file. 
	fid=fopen(['Visual_Search' num2str(SbjID) '.out'],'a');
   	fprintf(fid, 'Subject     Trial   ss  tid     RT   resp  Error\r');
   
	for i=1:endtrial
		fprintf(fid, '%-8s   %3d   %2d    %d   %4.0f      %d     %d\r', ...
                     num2str(SbjID), DATA(i).trial, DATA(i).setsize, ...
                     DATA(i).tid, DATA(i).rt, DATA(i).resp, DATA(i).error);
    end;
    fclose(fid);
    clear all;

       
   