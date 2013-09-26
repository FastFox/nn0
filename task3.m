row = 0;
figure
for n = [9, 15, 100]
	y = @(x) 0.5 + 0.4*sin(2*pi*x);

	%px = rand(n, 1);
	px = [1/n:1/n:1]';
	py = rand(n, 1);

	train = y(px) + 0.05*randn(n, 1);
	test = y(py) + 0.05*randn(n, 1);

	p = arrayfun(y, [1/n:1/n:1]);
	subplot(3, 2, row * 2 + 2);
	hold on
	plot([1/n:1/n:1], p, 'g')
	plot([1/n:1/n:1], train, 'db')
	%print -dpng '3b'


	dBest = 1;
	rmseBest = 1;
	yBest = px;
	rmse = zeros(9, 1);
	for d = 1:9
		q = polyfit(px, train, d);
		y = polyval(q, px);
		rmse(d) = sqrt(mean((train - y).^2));
		%rmse = sqrt(mean((train - y).^2));
		if rmse(d) < rmseBest
			dBest = d;
			rmseBest = rmse(d);
			yBest = y;
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
	row = row + 1; 
end
