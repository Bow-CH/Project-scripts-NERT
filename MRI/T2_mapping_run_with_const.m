
n_1=[7,8];
label_1={'water','0.05 mg/ml','0.2 mg/ml','0.5 mg/ml','1 mg/ml','2 mg/ml','5 mg/ml'};
label_fitting_1={'water fitting','0.05 mg/ml fitting','0.2 mg/ml fitting','0.5 mg/ml fitting','1 mg/ml fitting','2 mg/ml fitting','5 mg/ml fitting'};
for a=(1:numel(n_1))
    [S,SD,TE,masking_phantom1_T2,file]=T2_mapping_first_set(n_1(a),masking_phantom1_T2,a+1);
    [T2,T2_upper,T2_lower]=plotting_T2_weight_with_const(S,SD,TE,label_1,label_fitting_1,n_1(a),a);
    T2_1{a}=T2;
    T2_upper_1{a}=T2_upper;
    T2_lower_1{a}=T2_lower;
end

clear T2 T2_upper T2_lower

n_2=[26,27,28];
label_2={'water','0.005 mg/ml','0.01 mg/ml','0.02 mg/ml','0.05 mg/ml','0.1 mg/ml','0.5 mg/ml'};
label_fitting_2={'water fitting','0.005 mg/ml fitting','0.01 mg/ml fitting','0.02 mg/ml fitting','0.05 mg/ml fitting','0.1 mg/ml fitting','0.5 mg/ml fitting'};
concentration_2=[0,0.005,0.01,0.02,0.05,0.1,0.5];
for a=(1:numel(n_2))
    [S,SD,TE,masking_phantom2_T2,file]=T2_mapping_first_set(n_2(a),masking_phantom2_T2,a+1);
    [T2,T2_upper,T2_lower]=plotting_T2_weight_with_const(S,SD,TE,label_2,label_fitting_2,n_2(a),a);
    T2_2{a}=T2;
    T2_upper_2{a}=T2_upper;
    T2_lower_2{a}=T2_lower;
end
[detection_limit]=calibration_T2(T2_2,T2_upper_2,T2_lower_2,concentration_2,n_2);

clear T2 T2_upper T2_lower

n_3=[158,159,160,166];
label_3={'water','5 mg/ml','5 mg/ml','5 mg/ml','5 mg/ml','5 mg/ml','5 mg/ml'};
label_fitting_3={'water fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting','5 mg/ml fitting'};
for a=(1:numel(n_3))
    [S,SD,TE,masking_phantom3_T2,file]=T2_mapping_second_set(n_3(a),masking_phantom3_T2,a+1);
    [T2,T2_upper,T2_lower]=plotting_T2_weight_with_const(S,SD,TE,label_3,label_fitting_3,n_3(a),a);
    T2_3{a}=T2;
    T2_upper_3{a}=T2_upper;
    T2_lower_3{a}=T2_lower;

end

clear T2 T2_upper T2_lower

n_4=[184,185,186,187];
label_4={'water','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml','0.05 mg/ml'};
label_fitting_4={'water fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting','0.05 mg/ml fitting'};
for a=(1:numel(n_4))
    [S,SD,TE,masking_phantom4_T2,file]=T2_mapping_second_set(n_4(a),masking_phantom4_T2,a+1);
    [T2,T2_upper,T2_lower]=plotting_T2_weight_with_const(S,SD,TE,label_4,label_fitting_4,n_4(a),a);
    T2_4{a}=T2;
    T2_upper_4{a}=T2_upper;
    T2_lower_4{a}=T2_lower;

end

clear T2 T2_upper T2_lower

n_5=[195,196,197,198];
label_5={'water','0.05 mg/ml','0.2 mg/ml','0.5 mg/ml','1 mg/ml','2 mg/ml','5 mg/ml'};
label_fitting_5={'water fitting','0.05 mg/ml fitting','0.2 mg/ml fitting','0.5 mg/ml fitting','1 mg/ml fitting','2 mg/ml fitting','5 mg/ml fitting'};
for a=(1:numel(n_5))
    [S,SD,TE,masking_phantom5_T2,file]=T2_mapping_second_set(n_5(a),masking_phantom5_T2,a+1);
    [T2,T2_upper,T2_lower]=plotting_T2_weight_with_const(S,SD,TE,label_5,label_fitting_5,n_5(a),a);
    T2_5{a}=T2;
    T2_upper_5{a}=T2_upper;
    T2_lower_5{a}=T2_lower;
end

clear T2 T2_upper T2_lower

n_6=[208,209,210,211];
label_6={'water','0.005 mg/ml','0.01 mg/ml','0.02 mg/ml','0.05 mg/ml','0.1 mg/ml','0.5 mg/ml'};
label_fitting_6={'water fitting','0.005 mg/ml fitting','0.01 mg/ml fitting','0.02 mg/ml fitting','0.05 mg/ml fitting','0.1 mg/ml fitting','0.5 mg/ml fitting'};
for a=(1:numel(n_6))
    [S,SD,TE,masking_phantom6_T2,file]=T2_mapping_second_set(n_6(a),masking_phantom6_T2,a+1);
    [T2,T2_upper,T2_lower]=plotting_T2_weight_with_const(S,SD,TE,label_6,label_fitting_6,n_6(a),a);
    T2_6{a}=T2;
    T2_upper_6{a}=T2_upper;
    T2_lower_6{a}=T2_lower;
end

[detection_limit]=calibration_T2(T2_6,T2_upper_6,T2_lower_6,concentration_2,n_6);

clear T2 T2_upper T2_lower

n_7=[221,222,223,224];
label_7={'water','2 mg/ml','0.2 mg/ml','0.1 mg/ml','0.05 mg/ml'};
label_fitting_7={'water fitting','2 mg/ml fitting','0.2 mg/ml fitting','0.1 mg/ml fitting','0.05 mg/ml fitting'};
for a=(1:numel(n_7))
    [S,SD,TE,masking_phantom7_T2,file]=T2_mapping_second_set_5(n_7(a),masking_phantom7_T2,a+1);
    [T2,T2_upper,T2_lower]=plotting_T2_set_5_weight_with_const(S,SD,TE,label_7,label_fitting_7,n_7(a),a);
    T2_7{a}=T2;
    T2_upper_7{a}=T2_upper;
    T2_lower_7{a}=T2_lower;
end

