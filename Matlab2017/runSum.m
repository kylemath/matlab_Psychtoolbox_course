function runSum(inc)

persistent TOTSUM

if isempty(TOTSUM)
    TOTSUM = 0;
end

TOTSUM = TOTSUM + inc;

TOTSUM