function [result] = calculate_tsp2opt(form)
% Example:
% load 'imbros' % Loads XY, Name
% calculate_tsp2opt(imbros)
close
result = {};
XY = form.XY;
% rand('state',100)
C = dists(XY,XY,'km');
makemap(XY)
h = pplot(XY,'r.');
% tic;
loc = [1 randperm(size(XY,1)-1)+1 1];
[loc,TC] = tsp2opt(loc,C,[],[],[],h);
% result.Time = toc; 
pplot({loc},XY,num2cellstr(1:size(XY,1)) )

names = {};
for j = 1:length(loc) - 1
    names{j} = form.Name(loc(j));
end
result.names = names;
result.loc = loc;
result.TC = TC;
title(['TSP 2-Opt Loc Seq Improvement: TC = ' num2str(sum(TC))])

% Check times
number = 15;
times = zeros(1,number);
locs = {}
costs = zeros(1,number);
for n = 1:number
    tic;
	loc = [1 randperm(size(XY,1)-1)+1 1];
	[loc,TC] = tsp2opt(loc,C,[],[],[],[]);
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

% figure(2)
% plot(times)
% grid on
% str = sprintf('TSP2OPT 2-optimal exchange procedure: Mean Calculation Times = %f and %d number of execution', result.mean_times,number);
% title(str)
