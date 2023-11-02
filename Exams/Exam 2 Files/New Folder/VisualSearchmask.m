%-------------------------------------------------------------
%   VisualSearch.m
%   Interrupted Visual Search Experiment.
%   Target is oriented T amongst distractor Ls
%   participants report target color: blue -> left 'x' key, red ',' key
% 
%   distractors and targets:
%   L oriented four ways: function ell
%   T oriented four ways: function tee
%
%   v2.0 -- (03/03/05) Alejandro Lleras & William Horrey
%
%   Last Updated 10 Apr 2017 JJH Yong
%   Masks added: script will call function mask.m to present masks for 100
%   msec after every stimulus array. Offtime reduced from 900 msec to 800
%   msec. Window pointer created for mask texture. Indiviual mask 
%   coordinates are set up under "populate grid" section's for loop. The
%   masks use the same jittered x and y coordinates as the distractors and 
%   targets so they will appear to mask directly over the stimuli. Another 
%   while loop was added to the "start search task" section to present the 
%   masks for 100 msec.
%
%   See script below for more detailed comments.
%
%   See VisualSearchmaskcond.m for script with masks as a condition.
%   
%-------------------------------------------------------------
clear;
SbjID = input('Enter Subject Number:   ');
Prac = input('Practice (y/n):','s');

%--------------------------------------------
%	Initialization
%--------------------------------------------
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
    background=[255 255 255];
    [window,rect]=Screen('OpenWindow',max(Screen('Screens')),background);
    %creating a white background for a texture;
    white_background=zeros(rect(4),rect(3),3);
    white_background(:,:,1)=255;
    white_background(:,:,2)=255;
    white_background(:,:,3)=255;
      
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
    offtime=refresh_rate-(2*ontime); %reduced to 800 ms
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
   
    DATA=repmat(struct('setsize',1,'tid',1,'rt',-1,'resp',-1,'error',-1),...
        1,T_TRIALS);
      % setsize 16, 32
	  % Target identity x:blue T, ,:red
      % RT
	  % response 1:'z' key, 2:'/' key
      % error 0:correct, 1:error
    DUMMY=DATA;   
    
    for i=1:T_TRIALS
        DUMMY(i).setsize=setsize(fix((i-1)/(T_TRIALS/numel(setsize)))+1);
        DUMMY(i).tid=mod(i,2)+1;     %tid = target id,  codes target color        
    end;

	seq=randperm(T_TRIALS);
    DATA=DUMMY(seq);
    for n=1:T_TRIALS
        DATA(n).trial=n;
    end;
    clear DUMMY;    


    % configure practice block
    if (strcmp(Prac,'y'))
		T_TRIALS=P_TRIALS;
    end;
    
    endtrial=T_TRIALS;
    
   
%--------------------------------------------
%	Run Trials
%--------------------------------------------    
    HideCursor;    
    
    for itrial=1:T_TRIALS
        %Draw trial contingent Screens
        % search Screen:

        search=Screen('MakeTexture',window,white_background);
        mask_array = Screen('MakeTexture',window,white_background);  %Make a window pointer for mask texture
        Screen('DrawLine',search,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
        Screen('DrawLine',search,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
         
                
        % set up search grid
        ssm1=DATA(itrial).setsize-1;
        locd=zeros(1,36);  
        %locd is passing variable for randomizing item locations in grid
        for i=1:ssm1
            locd(i)=1;
        end;
        locd(i+1)=2;
        
        iloc=randperm(numel(locd));
        for i=1:36
        	loc(i)=locd(iloc(i));    
        end;
   
        % determine distractor colors
        distcol = DATA(itrial).tid * ones(1,ssm1);  
        for n=1:(ceil(ssm1/2))
            distcol(n)=3-DATA(itrial).tid;    
        end;
        
        mixcol=randperm(ssm1);
        
        for n=1:ssm1
        	colour(n)=distcol(mixcol(n));    
        end;        
        
        n=1;
        % populate grid with distractors and target, set up mask
        for i=1:36
            if loc(i)==1   %1 is for distractors
                grid(i);
                tempcol=colour(n);
                tempor=fix(rand(1)*4)+1;
                tempx=cx+(round(rand(1)*jitter))+ offset;
                tempy=cy+(round(rand(1)*jitter))+ offset;
                ell(search,tempcol,tempor,tempx,tempy);
                mask(mask_array, tempx, tempy); %Calls the same x and y coordinates to present the mask
                n=n+1;
            elseif loc(i)==2 %2 is for target
                grid(i);
                tempcol = colour(n);
                tempor=fix(rand(1)*4)+1;
                tempx=cx+(round(rand(1)*jitter))+ offset;
                tempy=cy+(round(rand(1)*jitter))+ offset;
                tee(search,DATA(itrial).tid,tempor,tempx,tempy);
                mask(mask_array, tempx, tempy);
            elseif loc(i) == 0 %Added this elseif. Need to also present masks where there are no stimuli
                grid(i);
                tempor=fix(rand(1)*4)+1;
                tempx=cx+(round(rand(1)*jitter))+ offset;
                tempy=cy+(round(rand(1)*jitter))+ offset;
                mask(mask_array, tempx, tempy);
            end;
            clear tempx;
            clear tempy;
            clear tempor;
            clear tempcol;
        end;
        
        %getchar;

        while KbCheck;end; % wait until all keys are released.
        
 
               
  %%%%%%% start search task
        
      s=0;
        Screen('DrawLine',window,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
        Screen('DrawLine',window,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
        Screen('Flip',window,[],1);
        for ff=1:fixtime
            Screen('Flip',window,[],1);
        end;
        
	  t1=GetSecs;
      
      while ~KbCheck && (s < totaltime)
          c=0;
          
          while ~KbCheck && (c < ontime)
              %Screen('Flip',window);
              Screen('DrawTexture',window,search,[],[]);
              Screen('Flip',window);
              c=c+1;
              s=s+1;
          end;
          
          c=0;
          
          while ~KbCheck && (c < ontime) %So also for 100 msec
              Screen('DrawTexture',window,mask_array,[],[]); %Draw the mask array
              Screen('DrawLine',window,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre) %And also present the fixation
              Screen('DrawLine',window,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
              Screen('Flip',window);
              c=c+1; %Will last for 5 refreshes, ie up to 100 msec
              s=s+1; %Still need to keep track of s for total trial time
          end;
          
          c=0;
          
          while ~KbCheck && (c < offtime)
              %Screen('Flip',window);
              Screen('DrawLine',window,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
              Screen('DrawLine',window,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
              Screen('Flip',window);
              c=c+1;
              s=s+1;
          end;
      end;
      
        [touch, secs, keyCode] = KbCheck;
	    DATA(itrial).rt=(secs-t1)*1000;

                Screen('Flip',window,1);
                Screen('DrawLine',window,black,Xcentre-9,Ycentre,Xcentre+9,Ycentre)
                Screen('DrawLine',window,black,Xcentre,Ycentre-9,Xcentre,Ycentre+9)
                Screen('Flip',window);
                c=c+1;              
        
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
    Screen('CloseAll');
    
%--------------------------------------------
%	Output File
%--------------------------------------------  
	% open data file
	fid=fopen(['Visual_Search' num2str(SbjID) '.out'],'a');
   	fprintf(fid, 'Subject  Trial   ss  tid     RT   resp  Error\r');
   
    for i=1:endtrial
        fprintf(fid, '%-8s   %3d   %2d    %d   %4.0f      %d     %d\r', ...
            num2str(SbjID), DATA(i).trial, DATA(i).setsize, ...
            DATA(i).tid, DATA(i).rt, DATA(i).resp, DATA(i).error);
    end;
    fclose(fid);
    clear;

       
   