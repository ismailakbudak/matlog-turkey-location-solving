function [result] = calculate_vrpsavings(form)
% Example:
% load 'imbros' % Loads XY, Name
% calculate_vrpsavings(imbros)
close
result = {};
XY = form.XY;
C = dists(XY,XY,'km');
makemap(XY)
h = pplot(XY,'r.');
pplot(XY,form.Name(1:size(XY,1)));
tic;
[loc,TC] = vrpsavings(C,[],[],[],[],h);
result.Time = toc;
fprintf('%f\n',TC);
names = {};
for j = 1:length(loc{1}) - 1
    names{j} = form.Name(loc{1}(j));
end
result.names = names;

% Check times
number = 15;
t = zeros(1,number);
for n = 1:number
    tic;
    [loc,TC] = vrpsavings(C,[],[],[],[],h);
    t(n) = toc;
end

result.loc = loc;
result.TC = TC;
result.times = t;
result.mean_times = mean(result.times);

figure(2)
plot(t)
grid on
str = sprintf('VRP Savings: Mean Calculation Times = %f and %d number of execution', result.mean_times,length(t));
fprintf('%s\n\n',str)
title(str)
