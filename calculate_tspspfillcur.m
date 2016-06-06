function [result] = calculate_tspspfillcur(form)
% Example:
% load 'imbros' % Loads XY, Name
% calculate_tspspfillcur(imbros)
close
result = {};
XY = form.XY;
C = dists(XY,XY,'km');
tic;
loc = tspspfillcur(XY);
TD = locTC(loc,C)
result.Time = toc;

makemap(XY)
h = pplot(XY,'r.');
pplot(XY,form.Name(1:size(XY,1)));
pplot({loc},XY,'g')
 
fprintf('%f\n',TD);
names = {};
for j = 1:length(loc) - 1
    names{j} = form.Name(loc(j));
end
result.names = names;
result.loc = loc;
result.TD = TD;

% Check times
number = 1;
t = zeros(1,number);
for n = 1:number
    tic;
	loc = tspspfillcur(XY);
	TD = locTC(loc,C)
    t(n) = toc;
end
title(['Spacefilling curve TSP Loc Seq Construction: TD = ' num2str(sum(TD))])
result.times = t;
result.mean_times = mean(result.times);

figure(2)
plot(t)
grid on
str = sprintf('TSP Spacefilling curve: Mean Calculation Times = %f and %d number of execution', result.mean_times,length(t));
fprintf('%s\n\n',str)
title(str)
