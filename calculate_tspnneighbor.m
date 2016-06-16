function [result] = calculate_tspnneighbor(form)
% Calculate tspnneighbor result
% form parameter contains XY(coordinate of locations) and Name(name of location)
%
% Example:
% load 'imbros' % Loads XY, Name
% calculate_tspnneighbor(imbros)
%
close
result = {};
XY = form.XY;
C = dists(XY,XY,'km');
makemap(XY)
h = pplot(XY,'r.');
pplot(XY,num2cellstr(1:size(XY,1)));
% tic;
[loc,TC] = tspnneighbor(C,1,h); TC
[loc,TC,bestvtx] = tspnneighbor(C,[],h); TC, bestvtx
% result.Time = toc;
names = {};
for j = 1:length(loc) - 1
    names{j} = form.Name(loc(j));
end
result.names = names;
result.bestvtx = bestvtx;
result.loc = loc;
result.TC = TC;
title(['Nearest Neighbor TSP Loc Seq Construction: TC = ' num2str(sum(TC))])

% Check times
% Make calculation 'number' times and store result
number = 15;
t = zeros(1,number);
for n = 1:number
    tic;
	[loc,TC,bestvtx] = tspnneighbor(C,[],[]); TC, bestvtx
    t(n) = toc;
end

result.times = t;
result.mean_times = mean(result.times);

% % Show calculation time graphic
% figure(2)
% plot(t)
% grid on
% str = sprintf('TSP Nearest neighbor: Mean Calculation Times = %f and %d number of execution', result.mean_times,length(t));
% title(str)
