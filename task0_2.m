n = 100; % Dimensions
r = 0.5; % Radius

figure(1, 'visible', 'off')

% Calculate the amount of corners
c = arrayfun(@(n) 2^n, [1:n]);
subplot(2, 2, 1)
plot(c)
xlabel('Corners');

% Calculate the length of diagonal
d = arrayfun(@(n) n^.5, [1:n]);
subplot(2, 2, 2)
plot(d)
xlabel('Diagonal')

% Calculate the volume of the ball
vb = arrayfun(@(n) (pi^(n/2) * r^n) / gamma(n/2 + 1), [1:n]);
subplot(2, 2, 3)
plot(vb)
xlabel('Volume of B')

% Calculate the volume of the skin
s = 0.01; % Skin size
vs = arrayfun(@(n) 1^n - (1 - 2*s)^n, [1:n]);
subplot(2, 2, 4)
plot(vs)
xlabel('Volume of the 0.01-skin')

% Writing graphs to image
print -dpng '2'
