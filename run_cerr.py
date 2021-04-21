from oct2py import octave

octave.addpath('/ana/')
octave.push('sampleData', '/content/CERR/Unit_Testing/data_for_cerr_tests/CERR_plans/head_neck_ex1_20may03.mat.bz2')
octave.eval("radiomic_and_dosimetric_feature_extraction")

dose_result = octave.pull('dvhFeatS')
print (dose_result)
