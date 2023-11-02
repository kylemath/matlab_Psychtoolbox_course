% UofI.m - a script to get a list of numbers
% Kyle Mathewson, Jan 16, 2017

U = zeros(10,2);
U(1,1) = input('Pick any positive integer: ');;
U(1,2) = 1;
for i=2:10
    U(i,1) = U(i-1,1) .* (i+1); 
    U(i,2) = i;
end
U