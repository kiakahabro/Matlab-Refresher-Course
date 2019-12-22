function g = imageFilter(f,T)
%imageFilter Two dimensional convolution.
%g = imageFilter(f,T) performs the 2-D convolution of matricies f and T.
%and returns the result g, with the same size as f.
% - f is the input image.
% - T is the convolutional kernel.

%% Initialise output
%HINT:  Ensure it is a double.
g = zeros(size(f));
%% Interpret data
%HINT:  Store the size of f and T as useful variables.

%HINT:  Store the "step width" and "step height",
%   this is the distance either side of the center pixel

%% Create padded image
%HINT: Use "padarray" to pad the image f with a border of zeros.

%% Perform convolution
%HINT: Use a double for loop.

end

