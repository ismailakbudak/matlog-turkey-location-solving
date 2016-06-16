function [result] = calculate_vrpsavings(form)
% Calculate vrpsavings result
% form parameter contains XY(coordinate of locations) and Name(name of location)
%
% Author: Akbudak, I., Karagul, K., Gunduz, G., Tokat, S. (2016)
%
% Example:
% load 'imbros' % Loads XY, Name
% calculate_vrpsavings(imbros)
% 
close
result = {};
XY = form.XY;
C = dists(XY,XY,'km');
makemap(XY)
h = pplot(XY,'r.');
pplot(XY,num2cellstr(1:size(XY,1)));
% tic;
[loc,TC] = vrpsavings(C,[],[],[],[],h);
% result.Time = toc; 
names = {};
for j = 1:length(loc{1}) - 1
    names{j} = form.Name(loc{1}(j));
end
result.names = names;
result.loc = loc{1,1};
result.TC = TC;
title(sprintf('VRP Savings: Final TC = %f and %d Loc Seqs', sum(TC),length(TC)))

% Check times
% Make calculation 'number' times and store result
number = 15;
t = zeros(1,number);
for n = 1:number
    tic;
    [loc,TC] = vrpsavings(C,[],[],[],[],[]);
    t(n) = toc;
end
result.times = t;
result.mean_times = mean(result.times);

% % Show calculation time graphic
% figure(2)
% plot(t)
% grid on
% str = sprintf('VRP Savings: Mean Calculation Times = %f and %d number of execution', result.mean_times,length(t));
% title(str)
