function spacedout = newspace(low, high)
halfway = (high - low)/2 + low;
spaced2 = @(x,y) x:2:y;
firsthalf = spaced2(low, halfway);
secondhalf = eqspace(halfway, high);
spacedout = [firsthalf, secondhalf];

end


function out = eqspace(low, high)
out = linspace(low, high, 4);
end