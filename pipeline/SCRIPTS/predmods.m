% Bakeoff
% Predictions for community models

cd(hmscPath);

Sets = {'birds','butterfly','plant','trees','vegetation'}
dSizes=[300 600];
nsets=size(Sets,2)

dSz=dSizes(dsz)
set_no=Sets{s}

    
        for dTyp=1:3                % interpol, extrapol1, extrapol2

            for typ=1:4             % 1=without LF, 2=wihtout LF, with space as covariates, 3=with LF; 4=with spatial structure as LF

                folder = fullfile(wdpath,'FITS/');
                folderData = fullfile(wdpath,'DATA/');
                folderPred = fullfile(wdpath,'PREDICTIONS/');

                load(fullfile(folderPred,strcat('pred_',num2str(set_no),'_m',num2str(typ),'_d',num2str(dTyp),'_',num2str(dSz),'.mat')),'predList');
                predsM=cell2mat(predList);

                csvwrite(fullfile(folder, strcat('preds_',num2str(set_no),'_m',num2str(typ),'_d',num2str(dTyp),'_',num2str(dSz),'.csv')),predsM);
                
            end
        end
   