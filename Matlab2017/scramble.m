function rdow = scramble(word)

%this is our help function
%this explains our code

global GRAVITY
GRAVITY = 9.81;
t = GRAVITY.*3;


name_sz = length(word);
neworder = randperm(name_sz);
rdow = word(neworder);

