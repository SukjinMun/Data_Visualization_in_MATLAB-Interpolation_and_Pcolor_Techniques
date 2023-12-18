%%% Load data
data = load('densplt_.txt'); 

%%% Extract x, y, z, and intensity values 
x = data(:,1); 
y = data(:,2); 
z = data(:,3); 
intensity = data(:,4); 

%%% Create 1D arrays for different calculation uses below 
x_range = 0:0.02:6.0; 
y_range = 0:0.02:6.0; 
z_range = 0.1:0.2:5.9; 

%%% Create a new figure for the 3D plot
figure;

%%% Iterate over each unique value in z_range
for i = 1:length(z_range)
    %%% Set the current z-value
    z_value = z_range(i);
    
    %%% Find the indices of the rows in the data that correspond to the current z-value
    idx = find(abs(z - z_value) < 0.1);
    
    %%% For better visualization of data, only plot points with absolute value of intensity greater than zero
    nonzero_idx = find(abs(intensity(idx)) > 0.25);
    
    %%% Create a 3D scatter plot of the x-y-z values from the rows of x, y, and intensity that have indices in idx and absolute intensity greater than zero
    %
    % NOTE: deleted and replaced to z(idx(nonzero_idx)). But further notes
    % will be made. 
    %'z_value*ones(size(nonzero_idx))' creates a vector of the same size as 'nonzero_idx' with all elements equal to the value of 'z_value'. 
    % The 'ones' function creates a vector or matrix of ones, and the 'size' function returns the size of the input variable. 
    % By multiplying 'z_value' by this vector of ones, we create a vector of the same size as 'nonzero_idx' but with all elements equal to 'z_value'. 
    % This is used as the z-coordinate for the 3D scatter plot, allowing us to plot the intensity values for different combinations of x, y, and a single z value.
    %
    % 'y(idx(nonzero_idx))' returns a subset of the 'y' array, containing only the elements corresponding to the rows of the original data where both the z-value 
    % and the intensity value meet the given criteria.
    % Specifically, 'idx(nonzero_idx)' is a vector of indices pointing to the rows of the original data that satisfy the condition 'abs(intensity(idx)) > 0.25' 
    % and are also close to the current value of 'z_value' (within a tolerance of 0.1). 
    % The 'nonzero_idx' subset further filters this list to include only the rows where the absolute value of intensity is greater than 0.25.
    % By indexing the 'y' array with this subset of indices, the code selects only the 'y' values corresponding to the selected rows of the original data. 
    % This allows the code to create a 3D scatter plot of the selected x, y, and z values, 
    % using the intensity values to determine the color of each point in the scatter plot.
    %

    scatter3(x(idx(nonzero_idx)), y(idx(nonzero_idx)), z(idx(nonzero_idx)), 20, intensity(idx(nonzero_idx)), 'filled');
    
    %%% Use the hold on command to add each scatter plot to the same figure
    hold on;
end

%%% Set the axis limits, labels, and title
xlim([min(x_range), max(x_range)]);
ylim([min(y_range), max(y_range)]);
zlim([min(z_range), max(z_range)]);
xlabel('x');
ylabel('y');
zlabel('z');
title('Intensity VS x, y, and z');
colorbar;

%%% Use the hold off command to stop adding scatter plots to the figure
hold off;
