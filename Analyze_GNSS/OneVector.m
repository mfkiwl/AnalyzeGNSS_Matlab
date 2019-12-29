function [output_vector] =  OneVector(value_x,value_y,flag)
%  ���������ǣ��������value_y��value_x�������ϣ��ϲ�Ϊһ��������
%  value_y ��ά��Ϊ m*n   value_x ��ά��Ϊ m2*n2
%  nan ����Ϊ�յ���ֵ���ᱻȥ��
%  flag �����Ƿ�ɾ��0Ԫ�� ��ΪĳЩʱ��0Ԫ�ز�����ЧԪ�� ������ʵ���ڵ�
%  flag = 0  x y��ɾ��0Ԫ��
%  flag = 1  x ɾ��0Ԫ��
%  flag = 2  y ɾ��0Ԫ��
[m1,n1] = size(value_y);
[m2,n2] = size(value_x);

if  m1 ~= m2 || n1 ~= n2
    return; 
end

output_vector = [];
n = 0;
for sat = 1:n1
    for i = 1:m1
        if flag == 0 && (value_x(i,sat) == 0 || value_y(i,sat) == 0)
            continue;
        end
        
        if flag == 1 && value_x(i,sat) == 0 
            continue;
        end
        
        if flag == 2 && value_y(i,sat) == 0
            continue;
        end
        
        if isnan(value_y(i,sat))
            continue;
        end
        n = n+1;  
        output_vector(n,1) = value_x(i,sat);
        output_vector(n,2) = value_y(i,sat);
        
    end
end


end

