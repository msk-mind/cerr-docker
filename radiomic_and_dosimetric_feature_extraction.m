pkg load image
pkg load io
pkg load statistics
addpath(genpath('/content/CERR'))

planC = loadPlanC(sampleData, tempdir);
planC = updatePlanFields(planC);
planC = quality_assure_planC(sampleData, planC);

sampleParam = '/content/CERR/Jupyter_Notebooks/demoParams.json';
paramS = getRadiomicsParamTemplate(sampleParam);

indexS = planC{end};
strC = {planC{indexS.structures}.structureName};
strName = paramS.structuresC{1};
structNum = getMatchingIndex(strName,strC,'exact');
scanNum = getStructureAssociatedScan(structNum,planC);
doseNum = 1;
binWidth = 0.01;

structFieldName = ['struct_',repSpaceHyp(strName)];

%% Compute radiomic features
radiomicsFeatS = calcGlobalRadiomicsFeatures...
(scanNum, structNum, paramS, planC);

%% Compute DVH-based features
[doseV,volV] = getDVH(structNum,doseNum,planC);
[doseBinsV,volHistV] = doseHist(doseV,volV,binWidth);
dvhFeatS.meanDose = calc_meanDose(doseBinsV, volHistV);
dvhFeatS.d10 = calc_Dx(doseBinsV, volHistV, 10, 1);
dvhFeatS.v30 = calc_Vx(doseBinsV, volHistV, 30, 0);
dvhFeatS.MOH55 = calc_MOHx(doseBinsV, volHistV, 55);
