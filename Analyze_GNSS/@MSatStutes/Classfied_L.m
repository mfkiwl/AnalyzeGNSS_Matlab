function [ bool ] = Classfied_L( class_obj,SNR_delt,EL_delt )
%   MSatStutes���෽��
%   ��������ȡ��߶ȽǱ�ǩ������λ�в�
%   �в�����Ƿ�Ӧ�üӾ���ֵ��

% ������
    wait_h = waitbar(0,'������λ�в���');

% ������λ�в�
for f = 1:2
    for sys = 1:5
        if sys == 5
            [~,n,~] = size(class_obj.m_DD_L);
           data_end = n;
        else
           data_end = class_obj.m_PRN0(sys+1)-1;
        end
        
        data_begin = class_obj.m_PRN0(sys);
        L = class_obj.m_DD_L(:,data_begin:data_end,f);
        S = class_obj.m_CN0(:,data_begin:data_end,f);
        el = class_obj.m_EL(:,data_begin:data_end);
        [ Lall_CN0,Lsat_CN0,dimension_CN0 ] = Classfied_C(abs(L),S,SNR_delt,0 );
    
        [ Lall_el,Lsat_el,dimension_el ] = Classfied_C(abs(L),el,EL_delt,0 );
    
        Lall_CN0 = [Lall_CN0;zeros(100-dimension_CN0,2)];
        Lsat_CN0 = [Lsat_CN0;zeros(100-dimension_CN0,data_end-data_begin+2)]; % �����һ������Ϊ��һ����Index
        Lall_el = [Lall_el;zeros(100-dimension_el,2)];
        Lsat_el = [Lsat_el;zeros(100-dimension_el,data_end-data_begin+2)];
    
    % ��ֵ
    class_obj.m_index_CN0_dimension(sys,f) = dimension_CN0;
    class_obj.m_index_el_dimension(sys,f) = dimension_el;
    class_obj.m_index_CN0(:,sys,f) = Lall_CN0(:,1);
    class_obj.m_index_el(:,sys,f) = Lall_el(:,1);
    class_obj.m_Lsat_CN0(:,data_begin:data_end,f) = Lsat_CN0(:,2:end);
    class_obj.m_Lsat_el(:,data_begin:data_end,f) = Lsat_el(:,2:end);
    class_obj.m_Lall_CN0(:,sys,f) = Lall_CN0(:,end);
    class_obj.m_Lall_el(:,sys,f) = Lall_el(:,end);
    
    clear Pall_CN0 Psat_CN0 Pall_el Psat_el   
    
    waitbar((f-1)*5+sys/(2*5));
    
    end
end
    close(wait_h);
end

