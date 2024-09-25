
n_1=[10];
label_1={'water','0.05 mg/ml','0.2 mg/ml','0.5 mg/ml','1 mg/ml','2 mg/ml','5 mg/ml'};
label_fitting_1={'water fitting','0.05 mg/ml fitting','0.2 mg/ml fitting','0.5 mg/ml fitting','1 mg/ml fitting','2 mg/ml fitting','5 mg/ml fitting'};
for a=(1:numel(n_1))
    [S_1,SD_1,TR_1,masking_phantom1_T1]=T1_mapping_second_set(n_1(a),masking_phantom1_T1,a+1);
    [T1,T1_upper,T1_lower]=plotting_T1_takeout_2slides_weight_with_const(S_1,SD_1,TR_1,label_1,label_fitting_1,n_1(a),a);
    T1_1{a}=T1;
    T1_upper_1{a}=T1_upper;
    T1_lower_1{a}=T1_lower;
end

clear T1 T1_upper T1_lower

n_2=[20,22,23,25];
label_2={'water','0.005 mg/ml','0.01 mg/ml','0.02 mg/ml','0.05 mg/ml','0.1 mg/ml','0.5 mg/ml'};
label_fitting_2={'water fitting','0.005 mg/ml fitting','0.01 mg/ml fitting','0.02 mg/ml fitting','0.05 mg/ml fitting','0.1 mg/ml fitting','0.5 mg/ml fitting'};
concentration_2=[0,0.005,0.01,0.02,0.05,0.1,0.5];
for a=(1:numel(n_2))
    [S_2,SD_2,TR_2,masking_phantom2_T1]=T1_mapping_first_set_low_conc(n_2(a),masking_phantom2_T1,a+1);
    [T1,T1_upper,T1_lower]=plotting_T1_takeout_2slides_weight_with_const(S_2,SD_2,TR_2,label_2,label_fitting_2,n_2(a),a);
    T1_2{a}=T1;
    T1_upper_2{a}=T1_upper;
    T1_lower_2{a}=T1_lower;
end
[detection_limit]=calibration_T1(T1_2,T1_upper_2,T1_lower_2,concentration_2,n_2);

clear T1 T1_upper T1_lower

n_3=[157,169,177];
label_3={'water','5 mg/ml','5 mg/ml','5 mg/ml','5 mg/ml','5 mg/ml','5 mg/ml'};
label_fitting_3={'water fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting'};
for a=(1:numel(n_3))
    [S_3,SD_3,TR_3,masking_phantom3_T1]=T1_mapping_second_set(n_3(a),masking_phantom3_T1,a+1);
    [T1,T1_upper,T1_lower]=plotting_T1_takeout_2slides_weight_with_const(S_3,SD_3,TR_3,label_3,label_fitting_3,n_3(a),a);
    T1_3{a}=T1;
    T1_upper_3{a}=T1_upper;
    T1_lower_3{a}=T1_lower;
end

clear T1 T1_upper T1_lower

n_4=[183,182,190];
label_4={'water','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml'};
label_fitting_4={'water fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting'};
for a=(1:numel(n_4))
    [S_4,SD_4,TR_4,masking_phantom4_T1]=T1_mapping_second_set(n_4(a),masking_phantom4_T1,a+1);
    [T1,T1_upper,T1_lower]=plotting_T1_takeout_2slides_weight_with_const(S_4,SD_4,TR_4,label_4,label_fitting_4,n_4(a),a);
    T1_4{a}=T1;
    T1_upper_4{a}=T1_upper;
    T1_lower_4{a}=T1_lower;
end

clear T1 T1_upper T1_lower

n_5=[202,201,203];
label_5={'water','0.05 mg/ml','0.2 mg/ml','0.5 mg/ml','1 mg/ml','2 mg/ml','5 mg/ml'};
label_fitting_5={'water fitting','0.05 mg/ml fitting','0.2 mg/ml fitting','0.5 mg/ml fitting','1 mg/ml fitting','2 mg/ml fitting','5 mg/ml fitting'};
for a=(1:numel(n_5))
    [S_5,SD_5,TR_5,masking_phantom5_T1]=T1_mapping_second_set(n_5(a),masking_phantom5_T1,a+1);
    [T1,T1_upper,T1_lower]=plotting_T1_takeout_2slides_weight_with_const(S_5,SD_5,TR_5,label_5,label_fitting_5,n_5(a),a);
    T1_5{a}=T1;
    T1_upper_5{a}=T1_upper;
    T1_lower_5{a}=T1_lower;
end

clear T1 T1_upper T1_lower

n_6=[215,214,216];
label_6={'water','0.005 mg/ml','0.01 mg/ml','0.02 mg/ml','0.05 mg/ml','0.1 mg/ml','0.5 mg/ml'};
label_fitting_6={'water fitting','0.005 mg/ml fitting','0.01 mg/ml fitting','0.02 mg/ml fitting','0.05 mg/ml fitting','0.1 mg/ml fitting','0.5 mg/ml fitting'};
for a=(1:numel(n_6))
    [S_6,SD_6,TR_6,masking_phantom6_T1]=T1_mapping_second_set(n_6(a),masking_phantom6_T1,a+1);
    [T1,T1_upper,T1_lower]=plotting_T1_takeout_2slides_weight_with_const(S_6,SD_6,TR_6,label_6,label_fitting_6,n_6(a),a);
    T1_6{a}=T1;
    T1_upper_6{a}=T1_upper;
    T1_lower_6{a}=T1_lower;
end

[detection_limit]=calibration_T1(T1_6,T1_upper_6,T1_lower_6,concentration_2,n_6);

clear T1 T1_upper T1_lower

n_7=[228,227,229];
label_7={'water','2 mg/ml','0.2 mg/ml','0.1 mg/ml','0.05 mg/ml'};
label_fitting_7={'water fitting','2 mg/ml fitting','0.2 mg/ml fitting','0.1 mg/ml fitting','0.05 mg/ml fitting'};
for a=(1:numel(n_7))
    [S_7,SD_7,TR_7,masking_phantom7_T1]=T1_mapping_second_set_5(n_7(a),masking_phantom7_T1,a+1);
    [T1,T1_upper,T1_lower]=plotting_T1_takeout_2slides_set5_weight_with_const(S_7,SD_7,TR_7,label_7,label_fitting_7,n_7(a),a);
    T1_7{a}=T1;
    T1_upper_7{a}=T1_upper;
    T1_lower_7{a}=T1_lower;
end

