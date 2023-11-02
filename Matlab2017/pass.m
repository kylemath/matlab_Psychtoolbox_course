pwd = input('Please enter your password: ','s');
pwdsize = length(pwd); %check size of pwd

if (pwdsize < 6)
    disp('The password is too short! ');
else
    disp('Your password is valid! ');
end


