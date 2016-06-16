function [result] = calculate_tsp2opt_comparision(first_loc,form)
% Calculate tsp2opt result with given inital location path
% form parameter contains XY(coordinate of locations) and Name(name of location)
%
% Author: Akbudak, I., Karagul, K., Gunduz, G., Tokat, S. (2016)
%
% Example:
% load 'imbros' % Loads XY, Name
% calculate_tsp2opt_comparision(loc,imbros)
%
close
result = {};
XY = form.XY;
% rand('state',100)
C = dists(XY,XY,'km');
makemap(XY)
h = pplot(XY,'r.');
% tic;
[loc,TC] = tsp2opt(first_loc,C,[],[],[],h);
% result.Time = toc; 
pplot({loc},XY,form.Name(1:size(XY,1)) )
% pplot({loc},XY,num2cellstr(1:size(XY,1)) )

names = {};
for j = 1:length(loc) - 1
    names{j} = form.Name(loc(j));
end
result.names = names;
result.loc = loc;
result.TC = TC;
title(['TSP 2-Opt Loc Seq Improvement: TC = ' num2str(sum(TC))])

% Check times
% Make calculation 'number' times and store result
number = 15;
times = zeros(1,number);
locs = {}
costs = zeros(1,number);
for n = 1:number
    tic;
	[loc,TC] = tsp2opt(first_loc,C,[],[],[],[]);
    times(n) = toc;
    locs{n} = loc;
    costs(n) = TC;
    fprintf('%f\n',TC);
end

result.calculations = {} 
result.calculations.times = times;
result.calculations.locs = locs;
result.calculations.costs = costs;

[cost,index] = min(result.calculations.costs)
min_loc = result.calculations.locs(index)
result.min_cost = cost
result.min_loc = min_loc

result.mean_times = mean(result.calculations.times);
result.mean_costs = mean(result.calculations.costs);

% % Show calculation time graphic
% figure(2)
% plot(times)
% grid on
% str = sprintf('TSP2OPT 2-optimal exchange procedure: Mean Calculation Times = %f and %d number of execution', result.mean_times,number);
% title(str)
