clear all
clc

pin = 0;
counter = 0;
while (pin ~= 1234)
    pin=input('What''s your pin number? ');
    counter = counter + 1; %increase the counter
    if (counter == 3)
        break
    end
end
if counter ~= 3
    disp('Correct');
end