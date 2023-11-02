clear all
clc

name = input('What''s your name? ','s');
randmood = floor(rand*4)+1; %computes a number randomly between 1 and 4 %could use randi

switch randmood
    case 1
        message = [name ' is happy!'];
    case 2
        message = [name ' is surprised!'];
    case 3
        message = [name ' is sad!'];
    case 4
        message = [name ' is angry!'];
end
disp(message)

