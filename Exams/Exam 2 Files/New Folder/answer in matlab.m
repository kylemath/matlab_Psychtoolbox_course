%%
% Q1:
% In this experiment, we firstly initialize all variables we might need such
% as ones related to time and grid positions. Secondly, we change DATA of ones
% into a set composed of 0,1,2 (in random indices), where 1 represent
% distractors.Then display 'L's and 'T's randomly based on DATA we have so far,
% and then set all keys to its corresponding functions. Finally, save all the 
% outputs of accuracy and RT of current subject.
% 
% Q2.1:
% cx and cy are used in both VisualSearch.m and grid function. Store it as
% global variables to keep the changes.
% 
% Q2.2:
% cx and cy represent the x and y coordinates of each grid of 36 grids (top
% left point coordinate exactly). And they are [] at beginning, until grid 
% function is called and cx and cy are assgined to position of each grid. And
% finally randomized with jitter and offsets we initialized at beginning.
% 
% Q3:
% To change to gray, we just change background color at beginning with:
% white_background(:,:,1)=100;
% white_background(:,:,2)=100;
% white_background(:,:,3)=100;
% To change the cross to red, we change the 'black' parameter in DrawLine into
% color matrix of [255,0,0].
% To change the color of 'L' we change the colvalue of ell.m into [255,255,0] and
% [0,0,0]. We do the same to colvalue of tee.m
% 
% Q4.1:
% Change the setsize at initialization into [4,8].
% 
% Q4.2:
% Change the setsize at initialization into [8,16,32].
% 
% Q5:
% We can imagine a grid of size of 36. we have built a list with random order
% of values-0,1,2, where 0 represents nothing drawn, 1 represents 'L', 2
% represents target which is 'T'. In short, i from 1:36 represent the positions
% in the grid and 0,1,2 represent what to display.
% 
% Q6.1:
% The methods above is more accurate. In our program, we only used c=0 and
% c=c+1 to caculate time which sometimes not actually time. In the script
% above, we have a t2 at start the timer of the machine itself and then get
% next secs by KbCheck which is an immidiate reaction. So that t3-t2 will
% be a more accurate time interval.
% 
% Q6.2:
% The code in program is more accurate. In program, we started a timer at t1
% and calculate the end time by 'DATA(itrial).rt=(secs-t1)*1000;'. Otherwise,
% in script above, it uses a count which is bounded by endtime and count=
% count+1 to count time in seconds. Similarly as previous question, time obtained
% from machine will be more accurate.
% 
% Q7.4:
% Use t3 and t2 to control the time interval taken by masked trials and use
% t5 and t4 to control that of unmasked trials. Set t3-t2 or t5-54 less than
% any value we want.




