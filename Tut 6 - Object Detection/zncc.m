function s = zncc(I1, I2)
%ZNCC zero-offset normalised cross correlation similarity measure.
%   s = zncc(I1, I2) calculates the ZNCC similarity measure between the
%   image patches I1 and I2.
%   IMPORTANT: Dimensions if I1 and I2 must be identical.

%% Calculate numerator and denominator
% HINT: store the average intensity of both I1 and I2, they will be useful.
snum = 0;
sden = 1;
%% Return result
s = snum/sden;
end

