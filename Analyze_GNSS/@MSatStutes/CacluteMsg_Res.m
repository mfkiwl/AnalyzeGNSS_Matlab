function [ bool ] = CacluteMsg_Res( class_obj )
%   MSatStutes���෽��
%   �����Ǽ���α��в����λ�в�ľ�ֵ�ͱ�׼��

 [~,satnum] = size(class_obj.m_SD_P(:,:,1));
 class_obj.m_mean_res = zeros(2,satnum,2);
 class_obj.m_std_res = zeros(2,satnum,2);

  % ������
 wait_h = waitbar(0,'ͳ��α��в�');
 
 % α��
for f = 1:2
    for sat = 1:satnum
        P = class_obj.m_SD_P(:,sat,f);
        if mean(P) == 0
            continue;
        end
        Locate = find(P == 0);
        P(Locate)=[];
      
        class_obj.m_mean_res(1,sat,f) = mean(P);
        class_obj.m_std_res(1,sat,f) = std(P);
        waitbar((f-1)*satnum+sat/(satnum*2));
        clear P
    end
end
 close(wait_h);
   
 % ������
 wait_h = waitbar(0,'ͳ����λ�в�');
% ��λ
for f = 1:2
    for sat = 1:satnum
        L = class_obj.m_DD_L(:,sat,f);
        if mean(L) == 0
            continue;
        end
        Locate = find(L == 0);
        L(Locate)=[];

        class_obj.m_mean_res(2,sat,f) = mean(L);
        class_obj.m_std_res(2,sat,f) = std(L);
        waitbar((f-1)*satnum+sat/(satnum*2));
        clear L
    end
end
   close(wait_h);
end

