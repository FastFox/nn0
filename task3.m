row = 0;
figure(1)
%figure(1, 'visible', 'off');

rmseC = zeros(3, 9);

for n = [9, 15, 100]
	y = @(x) 0.5 + 0.4*sin(2*pi*x);

	px = sort(rand(n, 1));
	%px = [1/n:1/n:1]';
	py = sort(rand(n, 1));

	train = y(px) + 0.05*randn(n, 1);
	test = y(py) + 0.05*randn(n, 1);

	p = arrayfun(y, [1/100:1/100:1]);

	subplot(3, 2, row * 2 + 2);
	hold on
	plot([1/100:1/100:1], p, 'g')
	plot(px, train, 'db')

	dBest = 1;
	rmseBest = 1;
	yBest = px;
	rmse = zeros(9, 1);
	for d = 1:9
    if d < n
		  q = polyfit(px, train, d);
		  y = polyval(q, px);
		  rmse(d) = sqrt(mean((train - y).^2));
  
		  rmseC(row + 1, d) = sqrt(mean((test - polyval(q, py)).^2));

		  if rmse(d) < rmseBest
			  dBest = d;
			  rmseBest = rmse(d);
			  yBest = y;
		  end
    end
	end
	plot(px, yBest, 'r');
	title(['Best degree = ' num2str(dBest)]);
	l = legend('Target', 'Training', 'Approximation');
	hold off

	subplot(3, 2, row * 2 + 1);
	plot([1:9], rmse)
	title(['N = ' num2str(n)]);
	xlabel('Degree');
	ylabel('RMSE');
	%dBest
	%plot(px, yBest, 'r')
	%rmseC=	sqrt(mean((train - test).^2))
  
  %row
  %size(py)
  %rmseC
  row = row + 1;
end
hold off
print -dpng '3b'

figure(2)
n = [9, 15, 100];
for i = [1, 2, 3]
  subplot(1, 3, i);
  plot([1:9], rmseC(i, :));
  title(['RSME of train set to test set. N = ' num2str(n(i))]);
  xlabel('Degree');
  ylabel('RSME');
end
print -dpng '3c'
