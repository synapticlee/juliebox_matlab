%written 2019-08-01
%just a one-liner to get the first third moments
%always skips nans

function [mom1,mom2,mom3] = getMoments(data, dim, whichFirst, whichSecond)

    if nargin < 4
        whichSecond = 'std'; %other options: var, stderr
        if nargin < 3
            whichFirst = 'mean'; %other options: median, mode
            if nargin < 2
                dim = 2 %(assumes short wide matrix e.g. fData of NNeurons x NTimepoints)
            end
        end
    end

    if any(isnan(data))
        warning('there are nans, but will skip..')
        data = data(~isnan(data));
    end

    switch whichFirst
    case 'mean'
        mom1 = mean(data,dim);
    case 'median'
        mom1 = median(data,dim);
    case 'mode'
        mom1 = mode(data,dim);
    end

    switch whichSecond
    case 'std'
        mom2 = std(data, [], dim); %sqrt(var)
    case 'var'
        mom2 = var(data, [], dim);
    case 'stderr'
        mom2 = std(data, [], dim)./numel(data);
    end

    mom3 = skewness(data, [], dim);
end
