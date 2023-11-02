%Exercise 1.

square = zeros(256, 256);
for n = 1:16;
    start = (n-1)*16 + 1;
    finish = n*16;
    if mod(n,2)
       square(1:finish, start:finish) = 1;
       square(start:finish, 1:finish) = 1;
    end
end


square = square*256;
colormap(gray(256));
image(square);


%Exercise 2 OLD
for n = 1:length(square)
    for o = 1:length(square)
        maxind = max(n,o);
        if square(n,o) == 0
            if mod(maxind, 16)
                square(n,o) = mod(maxind, 16) * 16;
            else
                square(n,o) = 256;
            end
        else
            if mod(maxind, 16)
                square(n,o) = square(n,o) - mod(maxind, 16) * 16;
            else
                square(n,o) = 0;
            end
        end
    end
end




%COLUMN GRATING
square = zeros(256,256);
for n = 1:256
    reverse = mod(n,32) >= 16;
    shade = mod(n,16);
    if ~reverse
        square(:,n) = shade*16;
    else
        square(:,n) = (16-shade)*16;
    end
end


% %Attempt
% %Below seems to work, do something.
square = zeros(256,256);
for n = 1:256
   for o = 1:256
      larger = max(n,o);
      val = mod(larger, 16);
      square(n,o) = val*16;
   end
end

image(square);
colormap(gray(256));


%Combination Attempt.
square = zeros(256,256);
for n = 1:256
    for o = 1:256
        larger = max(n,o);
        reverse = mod(larger,32) >= 16;
        shade = mod(larger,16);
        if ~reverse
            square(n,o) = shade*16;
        else
            square(n,o) = (16-shade)*16;
        end
    end
end
image(square);
colormap(gray(256));