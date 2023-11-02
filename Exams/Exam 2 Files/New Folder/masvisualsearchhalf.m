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
%   Last Updated November 30, 2005
%-------------------------------------------------------------

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
    offtime=refresh_rate-ontime-ontime; %800 ms
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
   
    DATA=repmat(struct('setsize',1,'tid',1,'rt',-1,'resp',-1,'error',-1, 'mask', -1),...
        1,T_TRIALS); %here, we add a mask column and make it all -1s, we will later randomize them to be either a 1 or a 2. 
      % setsize 16, 32
	  % Target identity x:blue T, ,:red
      % RT
	  % response 1:'z' key, 2:'/' key
      % error 0:correct, 1:error
    DUMMY=DATA;   
    
    for i=1:T_TRIALS
        DUMMY(i).setsize=setsize(fix((i-1)/(T_TRIALS/numel(setsize)))+1);
        DUMMY(i).tid=mod(i,2)+1;     %tid = target id,  codes target color
        DUMMY(i).mask=mod(i,2)+1; %Mask column is randomized to be either a 1 or a 2. If mask == 2, then have a masked trial, if mask ==1, then do not have a masked trial. 
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
        masksearch = Screen('MakeTexture', window, white_background) %here, we make a masksearch texture so we can use it instead of the search mask. 
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
        % populate grid with distractors and target
        for i=1:36
            if loc(i)==1   %1 is for distractors
                grid(i);
                tempcol=colour(n);
                tempor=fix(rand(1)*4)+1;
                tempx=cx+(round(rand(1)*jitter))+ offset;
                tempy=cy+(round(rand(1)*jitter))+ offset;
                ell(search,tempcol,tempor,tempx,tempy);
                mask(masksearch,tempx,tempy); %Here, we pull variables from our mask function to emulate the locations of the grid.m position. This will ensure that all distractor positions are filled with a mask
                n=n+1;
            elseif loc(i)==2 %2 is for target
                grid(i);
                tempor=fix(rand(1)*4)+1;
                tempx=cx+(round(rand(1)*jitter))+ offset;
                tempy=cy+(round(rand(1)*jitter))+ offset;
                tee(search,DATA(itrial).tid,tempor,tempx,tempy);
                mask(masksearch,tempx,tempy); %Here, we pull variables from our mask function to emulate the locations of the grid.m position. This will ensure that the target position is filled with a mask
            elseif loc(i) == 0
                grid(i);
                tempx=cx+(round(rand(1)*jitter))+ offset;
                tempy=cy+(round(rand(1)*jitter))+ offset;
                mask(masksearch,tempx,tempy); %If there is no shape in one of the 36 positions of grid.m, then we will still create a mask for that position. All 36 positions will be covered by a mask during the mask condition
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
        
	  while ~KbCheck & (s < totaltime),
            c=0;
            
            while ~KbCheck & (c < ontime),       
                  %Screen('Flip',window);
                  Screen('DrawTexture',window,search,[],[]);
                  Screen('Flip',window);
                c=c+1;
                s=s+1;
            end;
            
            c = 0;
            while ~KbCheck & (c < ontime),
                  if DATA(itrial).mask == 2   %While kbcheck is still 0, and while c <ontime, AND if DATA(itrial).mask == 2, then we can draw the mask condition and flip it for 100 ms
                  Screen('DrawTexture',window,masksearch,[],[]); %draws the mask stimuli
                  Screen('Flip',window); %flips the mask stimuli
                  elseif DATA(itrial).mask == 1  %if this is == 1, then we have no mask trial. c = 6 to preserve the time stamps 
                  c = 6
                  end
                c=c+1;
                s=s+1;
            end;
            
            
            c=0;
            
            while ~KbCheck & (c < offtime),
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
   	fprintf(fid, 'Subject     Trial   ss  tid     RT   resp  Error\r');
   
	for i=1:endtrial
		fprintf(fid, '%-8s   %3d   %2d    %d   %4.0f      %d     %d\r', ...
                     num2str(SbjID), DATA(i).trial, DATA(i).setsize, ...
                     DATA(i).tid, DATA(i).rt, DATA(i).resp, DATA(i).error);
    end;
    fclose(fid);
    clear all;

       
   