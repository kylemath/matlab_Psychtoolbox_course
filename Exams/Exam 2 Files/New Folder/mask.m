function mask(tp,x,y)

    % Take in a pointer where ever you are drawing mask too
    % Specify x and y location of the mask 

    %tp=texture index: which image to draw mask on
    %col=color
    %or=orientation of distractor
    %x and y are coordinates for top-left corner of letter
    
    lgth=20;
    xpos=x;
    ypos=y;
    width=3;
    
    colvalue=[0, 0, 0];
    
    % Up orientation of the "T" 
    Screen('DrawLine',tp,colvalue,xpos+(lgth/2),ypos,xpos+(lgth/2),ypos+lgth,width);
    Screen('DrawLine',tp,colvalue,xpos,ypos+(lgth/2),xpos+lgth,ypos+(lgth/2),width); %Need to add the (lgth/2) to the ypos to get the cross in the middle or else you just get a line
    
    % Up left orientation of the "L"
    Screen('DrawLine',tp,colvalue,xpos+lgth,ypos,xpos+lgth,ypos+lgth,width);
    Screen('DrawLine',tp,colvalue,xpos,ypos+lgth,xpos+lgth,ypos+lgth,width);
    
    % Down right orientation of the "L"
    Screen('DrawLine',tp,colvalue,xpos,ypos,xpos,ypos+lgth,width);
    Screen('DrawLine',tp,colvalue,xpos,ypos,xpos+lgth,ypos,width); 
    

end 
