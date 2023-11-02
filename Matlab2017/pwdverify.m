clear all
clc

pwd = 'secret';
attempt = input('What''s the pwd? ','s');

while ~strcmp(pwd,attempt)
    clear attempt;
    attempt = input('Invalid pwd, please try again. ','s');
end
disp('Correct. ');

    