%% ��ȡ��ǰ�в��ļ� .txt
% 12.20���޸� �޸ĵ�Ƶ����µ�BUG

%% �ṹ�嶨��
%  pri_all: prn sys el S[3] SD_rea_P[3] DD_res_L[3]
clear;

% �ඨ��
SatStutes = MSatStutes;
 path = 'K:\˶ʿ��ҵ����\���л�����GNSS�ź���������\data\20191010\PP7\��ǰ�в�\ȫʱ��\';
 name = 'PriRes_SD_GCREJ_LLIl';
%path = 'K:\˶ʿ��ҵ����\���л�����GNSS�ź���������\data\20191010\ZY1\ublox1\';
%name = 'HW1010_ZY1_ublox1_PriRes_SD_All';
% ȫʱ��
%beginTime = 0;
%endTime = 0;
% U���䳡��
%beginTime = 374773;
%endTime = 374970;
% ��������������ϳ���
%beginTime = 374990;
%endTime = 375361;
% ����Ͽ�ȳ���
 beginTime = 378667;
 endTime = 378890;
SNR_delt = 2;
EL_delt = 2;

%% ���ݶ�ȡ�������ʼ��
if ~SatStutes.Init(path,name,beginTime,endTime)
    disp('Init is wrong');
    exist(0);
end

%% Ѱ�Ҳв����ǩ�Ĺ�ϵ
MSatStutes.Classfied_P( SatStutes,SNR_delt,EL_delt );
MSatStutes.Classfied_L( SatStutes,SNR_delt,EL_delt );
MSatStutes.Classfied_SNR( SatStutes,EL_delt );

%% ͳ����ص���Ϣ
% �ļ���������Ķ��ǿ������ǣ������ǹ۲����� ��nsat_valid <= n_obs
% ÿ��ϵͳ��ÿ��Ƶ�ʵ�ƽ��������
% ÿ��ϵͳ��ÿ��Ƶ�ʵ�ƽ������ȡ�����ȱ�׼��
% ÿ��ϵͳ��ÿ��Ƶ�ʵ�ƽ��α��вƽ����λ�в�
MSatStutes.CacluteMsg_SNR_Vsat(SatStutes);
MSatStutes.CacluteMsg_Res(SatStutes);

%% ����ͼ��
% ����в���߶Ƚǻ�����ȵĹ�ϵ
% ��������ȡ��߶Ƚǡ��в�ʱ��ͼ
%SatStutes.display_time_SNR_el(-1,-1,-1,-1,-1);

% ����ÿ��ϵͳÿ������α�ࡢ����λ��ƽ��ֵ�ͱ�׼��
%SatStutes.display_sat_mean_std(-1,-1,-1);

% �����������α��в�Ĺ�ϵͼ
%SatStutes.display_res_SNR(-1,-1,-1,-1,-1);
%% �������
%  ģ����Ҫ����ȷ�� 
% %  model1 : y=a*e^(-b*x)+c   arg: a b c
%MSatStutes.Curve_Fitting_Model1(SatStutes);
% %  model2 : y=sqrt(a+(1-a)*(x-min_SNR)/(max_SNR-min_SNR)) output:a
 %MSatStutes.Curve_Fitting_Model2(SatStutes);
 %  model3 : y=a*e^(-b*(x-min_SNR)/(max_SNR-min_SNR))+c   arg: a b c
% MSatStutes.Curve_Fitting_Model3(SatStutes);
% model4 : ��model3 �Ļ����� ȥ��LLI��־������
% MSatStutes.Curve_Fitting_Model4(SatStutes);
%% ������Ŀͳ��
MSatStutes.SatNumStatistics(SatStutes);