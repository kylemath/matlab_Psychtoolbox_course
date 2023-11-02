% To begin, set up a 1x7 cell array for column headers. Columns should be 
% subject number, block number, block size, number in block, difficulty, 
% accuracy, and time.

[num, txt, raw] = xlsread('example.xls');
headers = [{'SUBJNO'} {'BLOCKNUM'} {'BLOCKSIZE'} {'NUMINBLOCK'} {'DIFFIC'}...
    {'MATHACC'} {'MATHTIME'}];
fulldata = [headers; num2cell(num)];

index = ismember(raw, 'Cal');
index = index + ismember(raw, 'Prac1') + ismember(raw, 'Prac2');
data = cell2mat(raw(index,7));
disp(['Median of practice is ', num2str(median(data))])
index = find(cell2mat(raw(:,4)) == 4);
data = cell2mat(raw(index,7));
disp(['Mean for diff 4 is ', num2str(mean(data))])
start = find(~isnan(num(:,2)), 1, 'first');
index = find(num(start:end,3) == 3);
data = num(index,3);
disp(['Mean for set size 3 is ', num2str(mean(data))]);