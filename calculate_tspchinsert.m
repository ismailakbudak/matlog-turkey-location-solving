function [result] = calculate_tspchinsert(form)
% Calculate tspchinsert result
% form parameter contains XY(coordinate of locations) and Name(name of location)
%
% Author: Akbudak, I., Karagul, K., Gunduz, G., Tokat, S. (2016)
%
% Example:
% load 'imbros' % Loads XY, Name
% calculate_tspchinsert(imbros)
%
close
result = {};
XY = form.XY;
C = dists(XY,XY,'km');
makemap(XY)
h = pplot(XY,'r.');
pplot(XY,num2cellstr(1:size(XY,1)));
% tic;
loc = tspchinsert(XY,h);
TD = locTC(loc,C)
% result.Time = toc;
result.loc = loc;
result.TD = TD;

names = {};
for j = 1:length(loc) - 1
    names{j} = form.Name(loc(j));
end
result.names = names;
title(['Convex Hull Insertion TSP Loc Seq Construction: TD = ' num2str(sum(TD))])

% Check times
% Make calculation 'number' times and store result
number = 15;
t = zeros(1,number);
for n = 1:number
    tic;
	loc = tspchinsert(XY);
	TD = locTC(loc,C)
    t(n) = toc;
end 

result.times = t;
result.mean_times = mean(result.times);

% % Show calculation time graphic
% figure(2)
% plot(t)
% grid on
% str = sprintf('TSP Convex hull insertion: Mean Calculation Times = %f and %d number of execution', result.mean_times,length(t));
% title(str)
