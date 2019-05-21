function Addresses=loadNettraining(param)


%This function outputs the address to store training data and the address
%to load a trained net to initiala  given stage
Stage=param.Stage;
currentFolder = pwd;

Addresses.export = fullfile('./testing_result',['x' num2str(param.DownsamplingFactor),...
    '_',num2str(param.NoiseLevel),'dB','_Stage',num2str(param.Stage)],num2str(date) );  

if Stage==1
    % No need to initalize with a trained net in the noise less case. In
    % the noisy case it can be initialized with the net trained from stage
    % 1 in the noiseless case.
    Addresses.loadnet= '';
elseif  Stage==2
    Addresses.loadnet= '';
    if  isempty(Addresses.loadnet)

        % load the last modified/saved net from the previous stage.

        Addresses.loadnet=LastModifiedNet(param);
    end
        
elseif  Stage==3
    Addresses.loadnet= '';
    if  isempty(Addresses.loadnet)
        Addresses.loadnet=LastModifiedNet(param);
    end
end

cd(currentFolder)
end
function loadnet=LastModifiedNet(param)
    cd(fullfile('./training_result',['x' num2str(param.DownsamplingFactor),...
        '_',num2str(param.NoiseLevel),'dB','_Stage',num2str(param.Stage-1)]));
    DateFolders=[dir('0*');dir('1*');dir('2*');dir('3*')];
    [sorted, index]=sort({DateFolders.date});
    cd(DateFolders(index(end)).name);
    SavedNets=dir('*.mat');
    [sorted, index]=sort({SavedNets.date});
    filename=SavedNets(index(end)).name;
    loadnet= fullfile(pwd,filename);
end
