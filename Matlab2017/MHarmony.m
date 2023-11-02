clear all
clc

myage = '26';
status = 'single';
avail = 'immediate';
info = input('What information do you want to know? Enter 1 for age, 2 for status, 3 for availability, or 4 to quit. ');

switch info
    case 1
        txt = ['The age is ' myage];
        
    case 2
        txt = ['The status is ' status];
        
    case 3
        txt = ['The availability is ' avail];
        
    otherwise
        
        txt = ['You quitter!'];
        
end
disp(txt)

