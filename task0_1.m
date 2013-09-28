c = [2 5 7 6 4 2 1 0 0;
		 0 0 0 1 3 3 5 4 2];

% Initialization
jp = zeros(2, 9);
ccp = zeros(2, 9);
pp = zeros(1, 2);
sf = zeros(1, 9);
p = zeros(2, 9);

% Calculate joint, class-conditional and prior probability
for i = 1:2
	for j = 1:9
		jp(i, j) = c(i, j) / sum( c(1, :) + c(2, :) );
		ccp(i, j) = c(i, j) / sum( c(i, :) );
	end
	pp(i) = sum( c(i, :) ) / ( sum( c(1, :) ) + sum( c(2, :) ) );
end

% Calculate scaling factor
for j = 1:9
	sf(j) = ccp(1, j) * pp(1) + ccp(2, j) * pp(2);
end

% Calculate posteriors
for i = 1:2
	for j = 1:9
		p(i, j) = ccp(i, j) * pp(i) / sf(j);
	end
end

% Making graphs 
figure(1, 'visible', 'off')
subplot(1, 2, 1)
axis tight;
hold on
stairs(jp(1, :), 'b', 'linewidth', 5);
stairs(jp(2, :), 'r', 'linewidth', 5);
xlabel('Joint probabilities');
hold off

subplot(1, 2, 2)
axis tight;
hold on
stairs(p(1, :), 'b', 'linewidth', 5);
stairs(p(2, :), 'r', 'linewidth', 5);
xlabel('Posteriors');
hold off

% Writing graphs to image
print -dpng '1'

% Calculate misclassified cases for each splitting point
for split = 1:10 % Splitting point, left = C1, right = C2.
	ms = 0; % Total misclassified
	% C1 misclassified
	for j = split:9
		ms = ms + c(1, j);
	end
	% C2 misclassified
	for j = 1:(split - 1)
		ms = ms + c(2, j);
	end
	printf('At splitting point %i there are %i misclassified cases.\n', split, ms)
end
