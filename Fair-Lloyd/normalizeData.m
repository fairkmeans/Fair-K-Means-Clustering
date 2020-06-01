function [dataN] = normalizeData(data)

    [~, d] = size(data);
    flags = zeros(1,d);
    for i = 1:d
        data(:, i) = data(:, i) - mean(data(:, i));
        if std(data(:, i)) ~= 0
            data(:, i) = data(:, i) / std(data(:, i));
            flags(i) = 1;
        end
    end
    dataN = data(:, flags==1);
end

