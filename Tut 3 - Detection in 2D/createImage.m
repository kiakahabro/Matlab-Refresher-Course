function [data] = createImage(I,J,numToFind)
%CREATEIMAGE Creates a matrix of size [I,J] random integers between 0 and 255 with
%exactly one of them equal to numToFind

    uint8range	= 255;    

    data        = randi(uint8range-1,I,J);
    idx         = find(data>=numToFind);
    data(idx)   = data(idx)+1;
    
    idx42		= randi(numel(data),1);
    data(idx42) = numToFind;
    data        = uint8(data);
end

