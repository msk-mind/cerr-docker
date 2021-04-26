pkg load image
pkg load io
pkg load statistics
addpath(genpath('/content/CERR'))

scanName = 'niiScan';
old_planC = [];
save_flag = 0;
scanNum = 1;

planC = nii2cerr(scanFileName,scanName,old_planC,save_flag);
planC = updatePlanFields(planC);
planC = quality_assure_planC(scanFileName,planC);

planC = importNiftiSegToPlanC(planC,maskFileName,1);

indexS = planC{end};

disp(planC{indexS.structures})

sampleParam = '/content/CERR/Jupyter_Notebooks/demoParams.json';
paramS = getRadiomicsParamTemplate(sampleParam);

strC = {planC{indexS.structures}.structureName};
strName = paramS.structuresC{1};
structNum = getMatchingIndex(strName,strC,'exact');
scanNum = getStructureAssociatedScan(structNum,planC);
binWidth = 0.01;

structFieldName = ['struct_',repSpaceHyp(strName)];

%% Compute radiomic features
radiomicsFeatS = calcGlobalRadiomicsFeatures(scanNum, structNum, paramS, planC);
