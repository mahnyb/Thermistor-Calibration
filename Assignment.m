% Mahny Barazandehtar - 20210702004 - ES 272 - Assignment

clc; 
clear;
format long; 

% Load data from 'ntccal.dat'
data = load('ntccal.dat');
R = data(:, 1); % Resistance in Ohms
T = data(:, 2) + 273.15; % Temperature in Celsius converted to Kelvin

lnR = log(R);
Y = 1 ./ T; 
Z = [ones(size(lnR)), lnR, lnR.^3]; % the matrix for linear regression

% Linear regression to find the coefficients
coefficients = (Z' .* Z) \ (Z' .* Y);

% Extract the coefficients
A = coefficients(1);
B = coefficients(2);
C = coefficients(3);

% Calculate the fitted temperatures for plotting
T_fit = 1 ./ (A + B .* lnR + C .* lnR.^3);

% Plot the original data and the fitted curve
plot(R, T - 273.15, 'ro', R, T_fit - 273.15, 'b-'); % Plot original data in red circles and fitted curve in blue line
xlabel('Resistance (Ohms)');
ylabel('Temperature (Celsius)');
title('NTC Thermistor Calibration Data and Fit');
legend('Original Data', 'Fit Curve');

% Text annotation for the coefficients on the plot
text(min(R), max(T - 273.15), sprintf('A = %.3e\nB = %.3e\nC = %.3e', A, B, C), ...
     'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'BackgroundColor', 'white');


