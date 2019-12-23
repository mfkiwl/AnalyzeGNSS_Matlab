classdef MSatStutes < handle
    % MSatStutes
    % ��pri_all �еõ��� ����״̬ 
    
    % ���峣��
    properties (Constant)
    m_NSATGPS = 32;   % GPSϵͳ��������
    m_NSATGLO = 32;   % GLOϵͳ��������
    m_NSATBDS = 37;   % BDSϵͳ��������
    m_NSATGAL = 36;   % GALϵͳ��������
    m_NSATQZS = 4;
    m_SYSGPS = 1;
    m_SYSGLO = 2;
    m_SYSBDS = 3;
    m_SYSGAL = 4;
    m_SYSQAZ = 5;
    m_NFREQ = 3;
    m_PRN0 = [1;33;65;102;138];
    m_PRN1 = [32;64;101;137;140];
    end
    
    % ԭʼ�۲�����
    properties
    m_GPSTIME;
    m_CN0;   % ��ά���� [time,sat,f]
    m_CN0_mean; %ÿ������ϵͳ��ÿ��Ƶ�ʵ������ƽ��ֵ
    m_CN0_std; %ÿ������ϵͳ��ÿ��Ƶ�ʵ�����ȱ�׼��
    m_SD_P;  % ��ά���� [time,sat,f]
    m_DD_L;  % ��ά���� [time,sat,f]
    m_EL;    % ��ά���� [time,sat,f]
    m_LLI;   % ��ά���� [time,sat,f]
    m_LLI_P;   %LLI��־��Ϊ0ʱ����λ�в�� [1,sat,f]
    m_LLI_CN0; %LLI��־��Ϊ0ʱ������Ⱥ� [1,sat,f]
    m_LLI_el;  %LLI��־��Ϊ0ʱ�ĸ߶ȽǺ� [1,sat,f]
    m_LLI_P_SNR_G_1_y;
    m_LLI_P_SNR_G_1_n;
    m_LLI_P_SNR_R_1_y;
    m_LLI_P_SNR_R_1_n;
    m_LLI_P_SNR_E_1_y;
    m_LLI_P_SNR_E_1_n;
    m_LLI_P_SNR_C_1_y;
    m_LLI_P_SNR_C_1_n;
    m_LLI_P_SNR_J_1_y;
    m_LLI_P_SNR_J_1_n;
    m_LLI_P_SNR_G_2_y;
    m_LLI_P_SNR_G_2_n;
    m_LLI_P_SNR_R_2_y;
    m_LLI_P_SNR_R_2_n;
    m_LLI_P_SNR_E_2_y;
    m_LLI_P_SNR_E_2_n;
    m_LLI_P_SNR_C_2_y;
    m_LLI_P_SNR_C_2_n;
    m_LLI_P_SNR_J_2_y;
    m_LLI_P_SNR_J_2_n;
    m_Validsat; % ��ά���� [time,sys,f]
    m_ValidsatAll; %��Ԫ�۲�������
    m_ValidsatMean; %������ƽ��ֵ
    m_ValidsatStd; %��������׼��
    m_SatNum_n1; %Ƶ��1�����ݵ�����
    m_SatNum_n2; %Ƶ��2�����ݵ�����
    m_SatNum_nn; %Ƶ��1/2�������ݵ�����
    m_SatNum_N; %ĳ���ǳ��ֵ���Ԫ��
    m_SatNum_NLLI; %LLI��־���ֵĴ���[time,sat,f]
    m_rate_n1;
    m_rate_n2;
    m_rate_nn;
    m_rate_n1_sat;
    m_rate_n2_sat;
    m_rate_nn_sat;
    m_mean_rate_n1;
    m_mean_rate_n2;
    m_mean_rate_nn;
    
    m_SatNum_Nf; %ĳ������ĳ��Ƶ���й۲�ֵ���ֵ���Ԫ��Ŀ
    m_SatNum_Np; %�ÿ����Ǹ�Ƶ��α����ֵĴ���
    m_SatNum_Nl; %��λ����
    m_SatNum_ND; %�����ղ���
    m_rate_np;
    m_rate_nl;
    m_rate_nd;
    m_mean_rate_np;
    m_mean_rate_nl;
    m_mean_rate_nd;
    
    m_LLI_nsum;
    m_LLI_nrate;
    m_LLI_P_mean;
    m_LLI_CN0_mean;
    m_LLI_EL_mean;
    end
    
    % �ļ���ȡ
    properties
    m_path = '';
    m_filename = '';
    m_PriAllfile = '';
    m_Matfile = '';
    m_beginTime = 0;
    m_endTime = 0;
    end
    
    % CN0�������
    properties
    m_index_CN0_dimension;  % ��ά���� [sys,f]
    m_index_CN0;  % ��ά���� [index,sys,f]
    m_Pall_CN0;       % ��ά���� [index,sys,f]
    m_Psat_CN0;   % ��ά���� [index,sat,obstype]
    m_Lall_CN0;       % ��ά���� [index,sys,f]
    m_Lsat_CN0;   % ��ά���� [index,sat,f]    
    end
    
    % �����-�вX-Y����������Ͻ��
    properties
    m_Pall_CN0_model1;  %%model1:y=a*e^(-b*x)+c output:a b c ��ά����[output,sys,f]
    m_Lall_CN0_model1;  %%model1:y=a*e^(-b*x)+c output:a b c ��ά����[output,sys,f]
    
    m_Pall_CN0_model2;  %%model2 : y=sqrt(a+(1-a)*(x-min_SNR)/(max_SNR-min_SNR)) output:a ��ά����[output,sys,f]
    m_Lall_CN0_model2;
    
    m_Pall_CN0_model3;  %%model2 : y=sqrt(a+(1-a)*(x-min_SNR)/(max_SNR-min_SNR)) output:a ��ά����[output,sys,f]
    m_Lall_CN0_model3;
    
    m_Pall_CN0_model4;
    end
    
    % el�������
    properties
    m_index_el_dimension;  % ��ά���� [sys,f]
    m_index_el;  % ��ά���� [index,sys,f]
    m_Pall_el;       % ��ά���� [index,sys,f]
    m_Psat_el;   % ��ά���� [index,sat,f]
    m_Lall_el;       % ��ά���� [index,sys,f]
    m_Lsat_el;   % ��ά���� [index,sat,f]   
    m_SNRsat_el;
    m_SNRall_el;
    end
    
    % ������Ϣ
    properties
    m_mean;  % ����������������� [type,sys,f]
    m_std;   % ����������������� [ytpe,sys,f]
    m_mean_res; % ƽ���в� [type,sat,f]
    m_std_res; % �в��׼�� [type,sat,f]
    end
    
    % ��̬����
    methods 
      class_obj =  Init(class_obj,path,filename,beginTime,endTime); % ��ʼ����ز���
      bool = display_time_SNR_el(class_obj,sys,prn,f,OBSTYPE,flag_save); % ���Ʋв���SNR el������ͼ 
      bool = display_sat_mean_std(class_obj,sys,OBSTYPE,flag_save); % �������ǵĲв��׼��;�ֵ 
      bool = display_res_SNR(class_obj,sys,prn,f,OBSTYPE,flag_save); % �������ǵĲв�������ȵĹ�ϵ 
      [prn_insys,sys,prn_char] = findSat(class_obj,prn);
    end
    
    % ��̬����
    methods (Static)
      bool =  OpenPriallFile(class_obj);
      bool =  Classfied_P(class_obj,SNR_delt,EL_delt);
      bool =  Classfied_L(class_obj,SNR_delt,EL_delt);
      bool =  Classfied_SNR(class_obj,EL_delt)
      bool =  CacluteMsg_SNR_Vsat(class_obj);
      bool =  CacluteMsg_Res(class_obj);
      bool =  Curve_Fitting_Model1(class_obj);
      bool =  Curve_Fitting_Model2(class_obj);
      bool =  Curve_Fitting_Model3(class_obj);
      bool =  Curve_Fitting_Model4(class_obj);
      bool =  SatNumStatistics(class_obj);
    end
    
    
end

