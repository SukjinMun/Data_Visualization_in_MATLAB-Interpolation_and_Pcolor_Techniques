function output=desnplt_plotdata_fixedz_pcolor_1slice(filename,x_range,y_range,z_value)

% input as a test
% filename='densplt_.txt'; x_range = 0:0.2:6.0; y_range = 0:0.2:6.0; z_value = 0.1;
% z_range = 0.1:0.2:5.9;


%%% Load data
data = load(filename);

%%% Extract x, y, z and intensity values
x = data(:,1);
y = data(:,2);
z = data(:,3);
intensity = data(:,4);

%%% Create 1d arrays for different calculation uses below
%%% Note that the z_range has identical initial point, interval and end
%%% point as that of the original sample z data. This is because we would
%%% like to extract the same z value from the sample data in the for loop
%%% later on.
% x_range = 0:0.2:6.0;
% y_range = 0:0.2:6.0;
% z_range = 0.1:0.2:5.9;

%%% For each iteration of the loop, the code creates
%%% a pcolor plot of the intensity values for the corresponding z-value.
%%% This allows the user to visualize how the intensity values vary with
%%% respect to x and y at each z-level in the dataset.

% The length function returns the number of elements in an array.
% In this case, length(z_range) returns the number of unique z-values in the dataset.
% The loop runs for this very number of iterations,
% with the loop variable i taking on values from 1 to length(z_range).
% If one wants to check the result for the entire z-values, run "i = 1:length(z)"


figure;

% Find index of sample data for the currently selected z-value
% z_value = z_range(i);

% value 0.1 is a tolerance value to find indices of the sample data
% that correspond to a particular z-value. The purpose of this line
% is to simply extract the same z-values from the sample data:
% the find function is used to find the indices of the
% sample data that correspond to the current z value:
idx = find(abs(z-z_value)<0.1);

% Create 2D matrix of intensity values for current z-value
%
% Breakdown of For Loop:
% 1. Create an empty 2D matrix called intensity_matrix with the same
% dimensions as the x_range and y_range arrays.
%
% 2. Loop over the indices of x and y coordinates that correspond to
% the current z value.
%
% 3. Check whether the intensity value at the current index is not 0.
%
% 4. If the intensity value is not 0, populate the corresponding element
% of the intensity_matrix with the intensity value. Then, end the loop.
%
%
intensity_matrix = zeros(length(y_range), length(x_range));
for j = 1:length(idx)
    x_idx = find(x_range >= x(idx(j)), 1);
    y_idx = find(y_range >= y(idx(j)), 1);
    if intensity(idx(j)) ~= 0 % Exclude intensity values that are 0
        intensity_matrix(y_idx, x_idx) = intensity(idx(j));
    end
end

% Create pcolor plot of intensity matrix
pcolor(x_range, y_range, intensity_matrix);
%     shading interp;

% Set axis limits, labels, and title
xlim([min(x_range), max(x_range)]);
ylim([min(y_range), max(y_range)]);
xlabel('x');
ylabel('y');
title(['Intensity VS x&y, z = ',num2str(z_value)]);
colorbar;
colormap('jet');
shading flat;
% caxis([-1 0]);
caxis([-1e-6 0])



end
