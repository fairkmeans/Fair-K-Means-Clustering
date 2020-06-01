function [dataAll, svarAll, groupNames] = loadData( datasetName )

    if strcmp(datasetName, 'credit')
        dataAll = csvread('../Data/credit/credit_degree.csv', 2, 1);
        svarTemp = csvread('../Data/credit/educationAttribute.csv');
        svarAll = preProcessEductaionVector(svarTemp)';
        groupNames = {'Higher Education'; 'Lower Education'};
    elseif strcmp(datasetName, 'adult')
        dataAll = csvread('../Data/adult/adult_data_set.csv');
        svarAll = csvread('../Data/adult/adult_data_set_prot_attributes.csv');
        svarAll = svarAll + 1;
        groupNames = {'Female'; 'Male'};
    elseif strcmp(datasetName, 'LFW')
        load('../Data/LFW/LFW.mat', 'data', 'sensitive');
        dataAll = data;
        svarAll = sensitive;
        clear data sensitive;
        groupNames = {'Female'; 'Male'};
    elseif strcmp(datasetName, 'compasWB')
        load('../Data/compas/compas-data.mat', 'dataCompas', 'svarRace', 'raceNames');
        dataAll = dataCompas(svarRace==1 | svarRace==3, :);
        svarAll = (svarRace(svarRace==1 | svarRace==3) - 1) / 2 + 1;
        groupNames = raceNames([1,3]);
        clear dataCompas svarRace raceNames;
    end
end

