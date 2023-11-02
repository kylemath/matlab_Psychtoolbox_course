function mask(ptr,x,y);
    %ptr = window pointer
    %x,y are coordinates for the top left corner of the letter 
    
    lgth=20;
    width=3;
    
    
    Screen('FillRect',ptr,[0 0 0],[x+3 y+width x+10-width y+10-width]);
    Screen('FillRect',ptr,[0 0 0],[x+3 y+10+width x+10-width y+20-width]);
    Screen('FillRect',ptr,[0 0 0],[x+10+width y+width x+20-width y+10-width]);
    Screen('FillRect',ptr,[0 0 0],[x+10+width y+10+width x+20-width y+20-width]);
    
     
end
