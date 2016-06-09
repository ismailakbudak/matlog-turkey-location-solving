function [result] = calculate_vrpinsert(form)
% Example:
% load 'imbros' % Loads XY, Name
% calculate_vrpinsert(imbros)
close
result = {};
XY = form.XY;
C = dists(XY,XY,'km');
makemap(XY)
h = pplot(XY,'r.');
pplot(XY,form.Name(1:size(XY,1)));
% tic;
[loc,TC] = vrpinsert(C,[],[],[],[],h);
% result.Time = toc; 
names = {};
for j = 1:length(loc{1}) - 1
    names{j} = form.Name(loc{1}(j));
end
result.names = names;
result.loc = loc{1,1};
result.TC = TC;
title(sprintf('VRP Insert: Final TC = %f and %d Loc Seqs', sum(TC),length(TC)))

% Check times
number = 15;
t = zeros(1,number);
for n = 1:number
    tic;
    [loc,TC] = vrpinsert(C,[],[],[],[],[]);
    t(n) = toc;
end
result.times = t;
result.mean_times = mean(result.times);

% figure(2)
% plot(t)
% grid on
% str = sprintf('VRP Insert: Mean Calculation Times = %f and %d number of execution', result.mean_times,length(t));
% title(str)
