function [prn_insys,sys,prn_char] = findSat(class_obj,prn)
%   MSatStutes���෽��
%   ����prn����ϵͳ��prn_char��
charsys = ['G','R','C','E','J'];
for sys_i = 5:-1:1
    if prn < class_obj.m_PRN0(sys_i,1)
        continue;
    end
    prn_insys = prn - class_obj.m_PRN0(sys_i,1)+1;
    sys = sys_i;
    prn_char = [charsys(sys_i),num2str(prn_insys)];
    break;
end

end

