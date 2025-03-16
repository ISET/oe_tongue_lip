%% Plot light 405nm NEW reference

%Read in light spds
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (4 lights cali+verify)';

% LED 405nm + 450nm SPF 
% script written by Molly Mou

%% Lab notes
%1000mA 20.5 5.8sec
%100mA 2.9 7.1sec
%950mA 20 6.3sec
%450mA 11 6.4sec
%680mA 15.5 6.3 sec
%500mA 12  6.39sec
%50mA 1.5 9.0sec

% Correctly loading the spectral power distribution data for each current level
led405nm450spf_50mA = load('spd-2024-03-07-Calib-405nm450SPF-50mA.mat');
led405nm450spf_100mA = load('spd-2024-03-07-Calib-405nm450SPF-100mA.mat');
led405nm450spf_450mA = load('spd-2024-03-07-Calib-405nm450SPF-450mA.mat');
led405nm450spf_500mA = load('spd-2024-03-07-Calib-405nm450SPF-500mA.mat');
led405nm450spf_680mA = load('spd-2024-03-07-Calib-405nm450SPF-680mA.mat');
led405nm450spf_950mA = load('spd-2024-03-07-Calib-405nm450SPF-950mA.mat');
led405nm450spf_1000mA = load('spd-2024-03-07-Calib-405nm450SPF-1000mA.mat');

% Calculating LMD aimed radiance for each
L_led405nm450spf_50mA = trapz(led405nm450spf_50mA.wavelength, led405nm450spf_50mA.data);
L_led405nm450spf_100mA = trapz(led405nm450spf_100mA.wavelength, led405nm450spf_100mA.data);
L_led405nm450spf_450mA = trapz(led405nm450spf_450mA.wavelength, led405nm450spf_450mA.data);
L_led405nm450spf_500mA = trapz(led405nm450spf_500mA.wavelength, led405nm450spf_500mA.data);
L_led405nm450spf_680mA = trapz(led405nm450spf_680mA.wavelength, led405nm450spf_680mA.data);
L_led405nm450spf_950mA = trapz(led405nm450spf_950mA.wavelength, led405nm450spf_950mA.data);
L_led405nm450spf_1000mA = trapz(led405nm450spf_1000mA.wavelength, led405nm450spf_1000mA.data);

% Preparing data for plotting
x_led405nm450spf = [50, 100, 450, 500, 680, 950, 1000]; % Current levels in mA
y_led405nm450spf = [L_led405nm450spf_50mA, L_led405nm450spf_100mA, L_led405nm450spf_450mA, L_led405nm450spf_500mA, L_led405nm450spf_680mA, L_led405nm450spf_950mA, L_led405nm450spf_1000mA]; % Calculated radiance

% % Plotting the results
figure;  %hold on% Creates a new figure window
loglog(x_led405nm450spf, y_led405nm450spf, '-o');
title('Radiance vs. Current for LED 405nm with 450SPF');
xlabel('Current (mA)');
ylabel('Radiance');
grid on; % Adds a grid to the plot for easier visualization
identityLine;
%% 415nm 
% Correctly loading the spectral power distribution data for each current level
led415nm450spf_50mA = load('spd-2024-03-07-Calib-415nm450SPF-50mA.mat');
led415nm450spf_100mA = load('spd-2024-03-07-Calib-415nm450SPF-100mA.mat');
led415nm450spf_500mA = load('spd-2024-03-07-Calib-415nm450SPF-500mA.mat');
led415nm450spf_1000mA = load('spd-2024-03-07-Calib-415nm450SPF-1000mA.mat');
led415nm450spf_70mA = load('spd-2024-03-07-Calib-415nm450SPF-70mA.mat');
led415nm450spf_320mA = load('spd-2024-03-07-Calib-415nm450SPF-320mA.mat');
led415nm450spf_470mA = load('spd-2024-03-07-Calib-415nm450SPF-470mA.mat');
led415nm450spf_570mA = load('spd-2024-03-07-Calib-415nm450SPF-570mA.mat');

% Calculating LMD aimed radiance for each
L_led415nm450spf_50mA = trapz(led415nm450spf_50mA.wavelength, led415nm450spf_50mA.data);
L_led415nm450spf_100mA = trapz(led415nm450spf_100mA.wavelength, led415nm450spf_100mA.data);
L_led415nm450spf_500mA = trapz(led415nm450spf_500mA.wavelength, led415nm450spf_500mA.data);
L_led415nm450spf_1000mA = trapz(led415nm450spf_1000mA.wavelength, led415nm450spf_1000mA.data);
L_led415nm450spf_70mA = trapz(led415nm450spf_70mA.wavelength, led415nm450spf_70mA.data);
L_led415nm450spf_320mA = trapz(led415nm450spf_320mA.wavelength, led415nm450spf_320mA.data);
L_led415nm450spf_470mA = trapz(led415nm450spf_470mA.wavelength, led415nm450spf_470mA.data);
L_led415nm450spf_570mA = trapz(led415nm450spf_570mA.wavelength, led415nm450spf_570mA.data);

% Preparing data for plotting
% Preparing data for plotting in ascending order of current levels
x_led415nm450spf = [50, 70, 100, 320, 470, 500, 570, 1000]; % Current levels in mA

% Replace these placeholder values with your actual calculated radiance values
y_led415nm450spf = [L_led415nm450spf_50mA, L_led415nm450spf_70mA, L_led415nm450spf_100mA, L_led415nm450spf_320mA, L_led415nm450spf_470mA, L_led415nm450spf_500mA, L_led415nm450spf_570mA, L_led415nm450spf_1000mA];


% % Plotting the results with a different color
figure; % Creates a new figure window
loglog(x_led415nm450spf, y_led415nm450spf, '-o', 'Color', 'r'); % Using red color for distinction
title('Radiance vs. Current for LED 415nm with 450SPF');
xlabel('Current (mA)');
ylabel('Radiance');
grid on; % Adds a grid to the plot for easier visualization
identityLine;
%% 425nm
% Correctly loading the spectral power distribution data for each current level
led425nm450spf_50mA = load('spd-2024-03-07-Calib-425nm450SPF-50mA.mat');
led425nm450spf_100mA = load('spd-2024-03-07-Calib-425nm450SPF-100mA.mat');
led425nm450spf_360mA = load('spd-2024-03-07-Calib-425nm450SPF-360mA.mat');
led425nm450spf_500mA = load('spd-2024-03-07-Calib-425nm450SPF-500mA.mat');
led425nm450spf_510mA = load('spd-2024-03-07-Calib-425nm450SPF-510mA.mat');
led425nm450spf_730mA = load('spd-2024-03-07-Calib-425nm450SPF-730mA.mat');
led425nm450spf_1500mA = load('spd-2024-03-07-Calib-425nm450SPF-1500mA.mat');

% Calculating LMD aimed radiance for each
L_led425nm450spf_50mA = trapz(led425nm450spf_50mA.wavelength, led425nm450spf_50mA.data);
L_led425nm450spf_100mA = trapz(led425nm450spf_100mA.wavelength, led425nm450spf_100mA.data);
L_led425nm450spf_360mA = trapz(led425nm450spf_360mA.wavelength, led425nm450spf_360mA.data);
L_led425nm450spf_500mA = trapz(led425nm450spf_500mA.wavelength, led425nm450spf_500mA.data);
L_led425nm450spf_510mA = trapz(led425nm450spf_510mA.wavelength, led425nm450spf_510mA.data);
L_led425nm450spf_730mA = trapz(led425nm450spf_730mA.wavelength, led425nm450spf_730mA.data);
L_led425nm450spf_1500mA = trapz(led425nm450spf_1500mA.wavelength, led425nm450spf_1500mA.data);

% Preparing data for plotting
x_led425nm450spf = [50, 100, 360, 500, 510, 730, 1500]; % Current levels in mA
y_led425nm450spf = [L_led425nm450spf_50mA, L_led425nm450spf_100mA, L_led425nm450spf_360mA, L_led425nm450spf_500mA, L_led425nm450spf_510mA, L_led425nm450spf_730mA, L_led425nm450spf_1500mA]; % Calculated radiance

% Sorting data for ascending order plotting
[x_sorted, sortIndex] = sort(x_led425nm450spf);
y_sorted = y_led425nm450spf(sortIndex);

% % Plotting the results with a different color
figure; % Creates a new figure window
plot(x_sorted, y_sorted, '-o', 'Color', 'm'); % Using magenta color for distinction
title('Radiance vs. Current for LED 425nm with 450SPF');
xlabel('Current (mA)');
ylabel('Radiance');
grid on; % Adds a grid to the plot for easier visualization

%% 450nm
% Correctly loading the spectral power distribution data for each current level
led450nm450spf_50mA = load('spd-2024-03-07-Calib-450nm450SPF-50mA.mat');
led450nm450spf_100mA = load('spd-2024-03-07-Calib-450nm450SPF-100mA.mat');
led450nm450spf_120mA = load('spd-2024-03-07-Calib-450nm450SPF-120mA.mat');
led450nm450spf_500mA = load('spd-2024-03-07-Calib-450nm450SPF-500mA.mat');
led450nm450spf_530mA = load('spd-2024-03-07-Calib-450nm450SPF-530mA.mat');
led450nm450spf_1000mA = load('spd-2024-03-07-Calib-450nm450SPF-1000mA.mat');
led450nm450spf_1300mA = load('spd-2024-03-07-Calib-450nm450SPF-1300mA.mat');

% Calculating LMD aimed radiance for each
L_led450nm450spf_50mA = trapz(led450nm450spf_50mA.wavelength, led450nm450spf_50mA.data);
L_led450nm450spf_100mA = trapz(led450nm450spf_100mA.wavelength, led450nm450spf_100mA.data);
L_led450nm450spf_120mA = trapz(led450nm450spf_120mA.wavelength, led450nm450spf_120mA.data);
L_led450nm450spf_500mA = trapz(led450nm450spf_500mA.wavelength, led450nm450spf_500mA.data);
L_led450nm450spf_530mA = trapz(led450nm450spf_530mA.wavelength, led450nm450spf_530mA.data);
L_led450nm450spf_1000mA = trapz(led450nm450spf_1000mA.wavelength, led450nm450spf_1000mA.data);
L_led450nm450spf_1300mA = trapz(led450nm450spf_1300mA.wavelength, led450nm450spf_1300mA.data);

% Preparing data for plotting
x_led450nm450spf = [50, 100, 120, 500, 530, 1000, 1300]; % Current levels in mA
y_led450nm450spf = [L_led450nm450spf_50mA, L_led450nm450spf_100mA, L_led450nm450spf_120mA, L_led450nm450spf_500mA, L_led450nm450spf_530mA, L_led450nm450spf_1000mA, L_led450nm450spf_1300mA]; % Calculated radiance

% % Plotting the results
figure; % Creates a new figure window
loglog(x_led450nm450spf, y_led450nm450spf, '-o', 'Color', 'c'); % Using cyan color for distinction
title('Radiance vs. Current for LED 450nm with 450SPF');
xlabel('Current (mA)');
ylabel('Radiance');
grid on; % Adds a grid to the plot for easier visualization
identityLine;
%% ------Plot all lights

figure; % Creates a new figure window

% 405nm LED
plot(x_led405nm450spf, y_led405nm450spf, '-o', 'Color', 'b', 'DisplayName', '405nm', 'LineWidth', 2, 'MarkerSize', 8);
hold on; % Holds the current plot

% 415nm LED
plot(x_led415nm450spf, y_led415nm450spf, '-o', 'Color', 'r', 'DisplayName', '415nm', 'LineWidth', 2, 'MarkerSize', 8);

% 425nm LED
plot(x_led425nm450spf, y_led425nm450spf, '-o', 'Color', 'g', 'DisplayName', '425nm', 'LineWidth', 2, 'MarkerSize', 8);

% 450nm LED
plot(x_led450nm450spf, y_led450nm450spf, '-o', 'Color', 'm', 'DisplayName', '450nm', 'LineWidth', 2, 'MarkerSize', 8);

hold off; % Releases the plot hold

% Enhancing the overall plot aesthetics
title('Radiance vs. Current for 4 lights', 'FontSize', 14);
xlabel('Current (mA)', 'FontSize', 12);
ylabel('Radiance', 'FontSize', 12);
legend('show', 'FontSize', 12,'Location','southeast');
grid on; % Adds a grid to the plot for easier visualization

% Adjusting the axes properties for better visibility
set(gca, 'FontSize', 12); % Sets the font size of the tick labels and legend


%% Find current values 
% Assuming x_led... and y_led... arrays are defined for each wavelength as before
% Assuming x_led... and y_led... arrays are defined for each wavelength as before

% Define R - desired radiance value 
R = 50;

% Create figure for plotting
figure;
hold on;

% LED wavelengths to process
ledWavelengths = {'405nm450spf', '415nm450spf', '425nm450spf', '450nm450spf'};
colors = {'b', 'r', 'g', 'm'}; % Colors for each wavelength
x_led = {x_led405nm450spf, x_led415nm450spf, x_led425nm450spf, x_led450nm450spf};
y_led = {y_led405nm450spf, y_led415nm450spf, y_led425nm450spf, y_led450nm450spf};

% Loop through each LED wavelength
for i = 1:length(ledWavelengths)
    % Interpolate the curve
    x_interp = linspace(min(x_led{i}), max(x_led{i}), 10000);
    y_interp = interp1(x_led{i}, y_led{i}, x_interp, 'linear');

    % Find the intersection index
    [~, idx] = min(abs(y_interp - R));
    x_intersect = x_interp(idx);

    % Plotting the LED curve
    plot(x_led{i}, y_led{i}, '-o', 'Color', colors{i}, 'DisplayName', ledWavelengths{i});
    
    % Plotting the intersection marker
    plot(x_intersect, R, 'kp', 'MarkerSize', 10, 'MarkerFaceColor', colors{i});

    % Displaying the x_intersect value
    disp([ledWavelengths{i} ' x-intersect at current (mA): ' num2str(x_intersect)]);
end

% Enhancing the plot
title('Radiance vs. Current for LEDs with 450SPF and Intersection Points');
xlabel('Current (mA)');
ylabel('Radiance');
legend('show','Location','southeast');
grid on;
hold off;

%% Verify predicted current values 
% cd '/Users/ximou/Library/CloudStorage/OneDrive-Personal/Stanford/Matlab/Matlab Online Drive/2024-03-07/verify'
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (4 lights cali+verify)/verify';
% Load data for each specified current level
led405nm450spf_90mA = load('spd-2024-03-07-verif-405nm450SPF-90mA.mat');
led405nm450spf_100mA = load('spd-2024-03-07-verif-405nm450SPF-100mA.mat');
led405nm450spf_560mA = load('spd-2024-03-07-verif-405nm450SPF-560mA.mat');
led405nm450spf_570mA = load('spd-2024-03-07-verif-405nm450SPF-570mA.mat');
led405nm450spf_970mA = load('spd-2024-03-07-verif-405nm450SPF-970mA.mat');
led405nm450spf_980mA = load('spd-2024-03-07-verif-405nm450SPF-980mA.mat');

% Calculating LMD aimed radiance for each specified current level
L_led405nm450spf_90mA = trapz(led405nm450spf_90mA.wavelength, led405nm450spf_90mA.data);
L_led405nm450spf_100mA = trapz(led405nm450spf_100mA.wavelength, led405nm450spf_100mA.data);
L_led405nm450spf_560mA = trapz(led405nm450spf_560mA.wavelength, led405nm450spf_560mA.data);
L_led405nm450spf_570mA = trapz(led405nm450spf_570mA.wavelength, led405nm450spf_570mA.data);
L_led405nm450spf_970mA = trapz(led405nm450spf_970mA.wavelength, led405nm450spf_970mA.data);
L_led405nm450spf_980mA = trapz(led405nm450spf_980mA.wavelength, led405nm450spf_980mA.data);

% Preparing data for plotting in ascending order of current levels
x_led405nm450spf_currents = [90, 100, 560, 570, 970, 980]; % Current levels in mA
y_led405nm450spf_radiance = [L_led405nm450spf_90mA, L_led405nm450spf_100mA, L_led405nm450spf_560mA, L_led405nm450spf_570mA, L_led405nm450spf_970mA, L_led405nm450spf_980mA]; % Corresponding calculated radiance

% Plotting the results
figure; % Creates a new figure window
plot(x_led405nm450spf_currents, y_led405nm450spf_radiance, '-o', 'LineWidth', 2, 'MarkerSize', 8);
title('Radiance vs. Current for LED 405nm with 450SPF');
xlabel('Current (mA)');
ylabel('Radiance');
grid on; % Adds a grid to the plot for easier visualization

% Optionally, you can specify a different line and marker color if needed

% Displaying the radiance values for each current level
currentLevels = [90, 100, 560, 570, 970, 980]; % Current levels in mA
radianceValues = [L_led405nm450spf_90mA, L_led405nm450spf_100mA, L_led405nm450spf_560mA, L_led405nm450spf_570mA, L_led405nm450spf_970mA, L_led405nm450spf_980mA]; % Corresponding calculated radiance

disp('Radiance values for LED 405nm with 450SPF at specified current levels:');
for i = 1:length(currentLevels)
    disp(['Current: ' num2str(currentLevels(i)) 'mA, Radiance: ' num2str(radianceValues(i))]);
end

%% 415nm check
% Load data for each specified current level
led415nm450spf_80mA = load('spd-2024-03-07-verif-415nm450SPF-80mA.mat');
led415nm450spf_100mA = load('spd-2024-03-07-verif-415nm450SPF-100mA.mat');
led415nm450spf_450mA = load('spd-2024-03-07-verif-415nm450SPF-450mA.mat');
led415nm450spf_460mA = load('spd-2024-03-07-verif-415nm450SPF-460mA.mat');
led415nm450spf_910mA = load('spd-2024-03-07-verif-415nm450SPF-910mA.mat');
led415nm450spf_920mA = load('spd-2024-03-07-verif-415nm450SPF-920mA.mat');

% Calculating LMD aimed radiance for each specified current level
L_led415nm450spf_80mA = trapz(led415nm450spf_80mA.wavelength, led415nm450spf_80mA.data);
L_led415nm450spf_100mA = trapz(led415nm450spf_100mA.wavelength, led415nm450spf_100mA.data);
L_led415nm450spf_450mA = trapz(led415nm450spf_450mA.wavelength, led415nm450spf_450mA.data);
L_led415nm450spf_460mA = trapz(led415nm450spf_460mA.wavelength, led415nm450spf_460mA.data);
L_led415nm450spf_910mA = trapz(led415nm450spf_910mA.wavelength, led415nm450spf_910mA.data);
L_led415nm450spf_920mA = trapz(led415nm450spf_920mA.wavelength, led415nm450spf_920mA.data);

% Displaying the radiance values for each current level
currentLevels415 = [80, 100, 450, 460, 910, 920]; % Current levels in mA
radianceValues415 = [L_led415nm450spf_80mA, L_led415nm450spf_100mA, L_led415nm450spf_450mA, L_led415nm450spf_460mA, L_led415nm450spf_910mA, L_led415nm450spf_920mA]; % Corresponding calculated radiance

disp('Radiance values for LED 415nm with 450SPF at specified current levels:');
for i = 1:length(currentLevels415)
    disp(['Current: ' num2str(currentLevels415(i)) 'mA, Radiance: ' num2str(radianceValues415(i))]);
end



x_led415nm450spf = [50, 70, 100, 320, 470, 500, 570, 1000]; % Current levels in mA

% Replace these placeholder values with your actual calculated radiance values
y_led415nm450spf = [L_led415nm450spf_50mA, L_led415nm450spf_70mA, L_led415nm450spf_100mA, L_led415nm450spf_320mA, L_led415nm450spf_470mA, L_led415nm450spf_500mA, L_led415nm450spf_570mA, L_led415nm450spf_1000mA];


% Plotting the results with a different color
figure; % Creates a new figure window
plot(x_led415nm450spf, y_led415nm450spf, '-o', 'Color', 'r');
hold on
plot(currentLevels415,radianceValues415,'-o', 'Color', 'g'); 
% Using red color for distinction
title('Radiance vs. Current for LED 415nm with 450SPF');
xlabel('Current (mA)');
ylabel('Radiance');
grid on; % Adds a grid to the plot for easier visualization
hold off

%% 425nm
% Load data for each specified current level
led425nm450spf_80mA = load('spd-2024-03-07-verif-425nm450SPF-80mA.mat');
led425nm450spf_90mA = load('spd-2024-03-07-verif-425nm450SPF-90mA.mat');
led425nm450spf_100mA = load('spd-2024-03-07-verif-425nm450SPF-100mA.mat');
led425nm450spf_480mA = load('spd-2024-03-07-verif-425nm450SPF-480mA.mat');
led425nm450spf_490mA = load('spd-2024-03-07-verif-425nm450SPF-490mA.mat');
led425nm450spf_830mA = load('spd-2024-03-07-verif-425nm450SPF-830mA.mat');
led425nm450spf_840mA = load('spd-2024-03-07-verif-425nm450SPF-840mA.mat');

% Calculating LMD aimed radiance for each specified current level
L_led425nm450spf_80mA = trapz(led425nm450spf_80mA.wavelength, led425nm450spf_80mA.data);
L_led425nm450spf_90mA = trapz(led425nm450spf_90mA.wavelength, led425nm450spf_90mA.data);
L_led425nm450spf_100mA = trapz(led425nm450spf_100mA.wavelength, led425nm450spf_100mA.data);
L_led425nm450spf_480mA = trapz(led425nm450spf_480mA.wavelength, led425nm450spf_480mA.data);
L_led425nm450spf_490mA = trapz(led425nm450spf_490mA.wavelength, led425nm450spf_490mA.data);
L_led425nm450spf_830mA = trapz(led425nm450spf_830mA.wavelength, led425nm450spf_830mA.data);
L_led425nm450spf_840mA = trapz(led425nm450spf_840mA.wavelength, led425nm450spf_840mA.data);

% Displaying the radiance values for each current level
currentLevels425 = [80, 90, 100, 480, 490, 830, 840]; % Current levels in mA
radianceValues425 = [L_led425nm450spf_80mA, L_led425nm450spf_90mA, L_led425nm450spf_100mA, L_led425nm450spf_480mA, L_led425nm450spf_490mA, L_led425nm450spf_830mA, L_led425nm450spf_840mA]; % Corresponding calculated radiance

disp('Radiance values for LED 425nm with 450SPF at specified current levels:');
for i = 1:length(currentLevels425)
    disp(['Current: ' num2str(currentLevels425(i)) 'mA, Radiance: ' num2str(radianceValues425(i))]);
end

%% 450nm

% Load data for each specified current level
led450nm450spf_90mA = load('spd-2024-03-07-verif-450nm450SPF-90mA.mat');
led450nm450spf_100mA = load('spd-2024-03-07-verif-450nm450SPF-100mA.mat');
led450nm450spf_480mA = load('spd-2024-03-07-verif-450nm450SPF-480mA.mat');
led450nm450spf_490mA = load('spd-2024-03-07-verif-450nm450SPF-490mA.mat');
led450nm450spf_870mA = load('spd-2024-03-07-verif-450nm450SPF-870mA.mat');
led450nm450spf_880mA = load('spd-2024-03-07-verif-450nm450SPF-880mA.mat');

% Calculating LMD aimed radiance for each specified current level
L_led450nm450spf_90mA = trapz(led450nm450spf_90mA.wavelength, led450nm450spf_90mA.data);
L_led450nm450spf_100mA = trapz(led450nm450spf_100mA.wavelength, led450nm450spf_100mA.data);
L_led450nm450spf_480mA = trapz(led450nm450spf_480mA.wavelength, led450nm450spf_480mA.data);
L_led450nm450spf_490mA = trapz(led450nm450spf_490mA.wavelength, led450nm450spf_490mA.data);
L_led450nm450spf_870mA = trapz(led450nm450spf_870mA.wavelength, led450nm450spf_870mA.data);
L_led450nm450spf_880mA = trapz(led450nm450spf_880mA.wavelength, led450nm450spf_880mA.data);

% Displaying the radiance values for each current level
currentLevels450 = [90, 100, 480, 490, 870, 880]; % Current levels in mA
radianceValues450 = [L_led450nm450spf_90mA, L_led450nm450spf_100mA, L_led450nm450spf_480mA, L_led450nm450spf_490mA, L_led450nm450spf_870mA, L_led450nm450spf_880mA]; % Corresponding calculated radiance

disp('Radiance values for LED 450nm with 450SPF at specified current levels:');
for i = 1:length(currentLevels450)
    disp(['Current: ' num2str(currentLevels450(i)) 'mA, Radiance: ' num2str(radianceValues450(i))]);
end


