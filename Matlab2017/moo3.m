clear all
clc

matrix = input('enter a two dimensional matrix: ');
s = size(matrix);
tot = 0;

% for r = 1:s(1)
%     for c = 1:s(2)
%         tot = tot + matrix(r,c);
%     end
% end


tot = sum(sum(matrix));
disp(tot);