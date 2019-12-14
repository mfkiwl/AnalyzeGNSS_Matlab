function [ bool ] = display_res_SNR(class_obj,Sys,Prn,F,OBSTYPE,flag_save)
%   MSatStutes���෽��
%   ���Ʋв���SNR�Ķ�ά��ͼ �������������������£�
%   sys : 1: GPS 2: GLONASS 3:BDS 4:GAL 5:QZS -1:all
%   prn : x:ĳ��������ϵͳ�ڵ�prn -1:all
%   f   : 1:Ƶ��һ 2:Ƶ�ʶ� -1:all
%   OBSTYPE: 1:α�� 2:��λ -1:all
%   flag_save: 0��not save 1:save  �ڵ�ǰĿ¼�´����ļ���
%   1111�汾�Ƚ�֧��ȫ������

% �����ļ��д��� ����ϵͳ����
% �ļ�������Ϊ   SNRRES_SYS
% ͼ����������Ϊ SNRRES_prn_f_OBSTYPE.png
% ���������һ��ͼƬ��SNRRES_all_f_OBSTYPE.png

folder = cell(5,1);
folder{1} = [class_obj.m_path,'SNRRES_GPS'];
folder{2} = [class_obj.m_path,'SNRRES_GLO'];
folder{3} = [class_obj.m_path,'SNRRES_BDS'];
folder{4} = [class_obj.m_path,'SNRRES_GAL'];
folder{5} = [class_obj.m_path,'SNRRES_QZS'];
for sys = 1:5
    if ~exist(cell2mat(folder(sys)))
        mkdir(cell2mat(folder(sys)));
    else
        rmdir(cell2mat(folder(sys)),'s');
        mkdir(cell2mat(folder(sys)));
    end
end

display_res_SNR_subP(class_obj,folder,Sys,Prn,F,flag_save);
display_res_SNR_subL(class_obj,folder,Sys,Prn,F,flag_save);

end

function [ bool ] = display_res_SNR_subP(class_obj,folder,Sys,Prn,F,flag_save)

% ������
 wait_h = waitbar(0,'�����ܵ�α��в�������ȹ�ϵͼ��');

% ���α����ͼ��
for f = 1:2
    for sys = 1:2
        
        X = class_obj.m_index_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sys,f);
        Y = class_obj.m_Pall_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sys,f);
        
        filename = [cell2mat(folder(sys)),'\\SNRRES_all_',num2str(f),'_P'];
        fh = figure('Visible','off');
        plot(X,Y,'g.','MarkerSize',15);
        saveas(fh,filename,'png');
        close(fh);    
        clear X Y
        waitbar((f-1)*5+sys/10);
    end
end

 close(wait_h);
 
 % ������
 wait_h = waitbar(0,'����ÿ�����ǵ�α��в�������ȹ�ϵͼ��');
 
% ���α��ͼ��
for f =1:2
for sys = 1:5
       if sys == 5
            [~,n,~] = size(class_obj.m_SD_P);
           data_end = n;
        else
           data_end = class_obj.m_PRN0(sys+1)-1;
       end
        data_begin = class_obj.m_PRN0(sys);
        
            for sat = data_begin:data_end
                 % dimension�ǰ����ܵ�ά����˵�� ��˵������ǻ�����ֵ
                 X = class_obj.m_index_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sys,f);
                 Y = class_obj.m_Psat_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sat,f);
                 if std(Y) == 0
                     continue;
                 end
                 Locate = find(Y == 0);
                 Y(Locate) = nan;

                 [~,~,prn_char] = class_obj.findSat(sat);
                 filename = [cell2mat(folder(sys)),'\\SNRRES_',prn_char,'_',num2str(f),'_P'];
                 fh = figure('Visible','off');
                  plot(X,Y,'r.','MarkerSize',15);
                 saveas(fh,filename,'png');
                 close(fh);
                 clear X Y Locate
            end
   waitbar((f-1)*5+sys/10);
end
end
   close(wait_h);
end


function [ bool ] = display_res_SNR_subL(class_obj,folder,Sys,Prn,F,flag_save)

% ������
 wait_h = waitbar(0,'�����ܵ���λ�в�������ȹ�ϵͼ��');

% ���α����ͼ��
for f = 1:2
    for sys = 1:2
        
        X = class_obj.m_index_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sys,f);
        Y = class_obj.m_Lall_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sys,f);
        
        filename = [cell2mat(folder(sys)),'\\SNRRES_all_',num2str(f),'_L'];
        fh = figure('Visible','off');
         plot(X,Y,'g.','MarkerSize',15);
        saveas(fh,filename,'png');
        close(fh);    
        clear X Y
        waitbar((f-1)*4+sys/8);
    end
end

 close(wait_h);
 
 % ������
 wait_h = waitbar(0,'����ÿ�����ǵ���λ�в�������ȹ�ϵͼ��');
 
% ���α��ͼ��
for f =1:2
for sys = 1:5
       if sys == 5
            [~,n,~] = size(class_obj.m_DD_L);
           data_end = n;
        else
           data_end = class_obj.m_PRN0(sys+1)-1;
       end
        data_begin = class_obj.m_PRN0(sys);
        
            for sat = data_begin:data_end
                 % dimension�ǰ����ܵ�ά����˵�� ��˵������ǻ�����ֵ
                 X = class_obj.m_index_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sys,f);
                 Y = class_obj.m_Lsat_CN0(1:class_obj.m_index_CN0_dimension(sys,f),sat,f);
                 
                 if std(Y) == 0
                     continue;
                 end
                 
                 Locate = find(Y == 0);
                 Y(Locate) = nan;

                 [~,~,prn_char] = class_obj.findSat(sat);
                 filename = [cell2mat(folder(sys)),'\\SNRRES_',prn_char,'_',num2str(f),'_L'];
                 fh = figure('Visible','off');
                  plot(X,Y,'r.','MarkerSize',15);
                 saveas(fh,filename,'png');
                 close(fh);
                 clear X Y Locate
            end
   waitbar((f-1)*5+sys/10);
end
end
   close(wait_h);
end