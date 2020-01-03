function g = imageFilter(f,T,metric)
%imageFilter Two dimensional convolution and template matching.
%    g = imageFilter(f,T) performs the 2-D convolution of matricies f and T.
%    and returns the result g, with the same size as f.
%    - f is the input image.
%    - T is a template.
% 
%    g = imageFilter(..., metric) performs a template matching operation
%    using the function handle metric as a similarity measure.

%% Convert f and T to a double
f = double(f);
T = double(T);
%% Initialise output
g = zeros(size(f));
%% TODO: Copy the completed imageFilter from Tutorial 5.

%% TODO: Instead of just performing a convolution,
%   - Check to see if a "metric" is supplied (HINT: use nargin).
%   - If so, call metric(T,patch), otherwise perform a convolution.
end

