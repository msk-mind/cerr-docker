from oct2py import octave
import os

octave.addpath('/ana/')
octave.push('scanFileName', '/data/VolumetricImage-randomize_contours_s3-125/volumes_CT_si3_x_1.25_y_1.25_z_1.25.nii')
octave.push('maskFileName', '/data/VolumetricLabel-randomize_contours_s3-125/volumes_CT_si3_x_1.25_y_1.25_z_1.25_labeled_COMBINED_roi.nii')
octave.eval("radiomic_and_heterogeneity_extraction")

result1 = octave.pull('radiomicsFeatS')
print (result1)
