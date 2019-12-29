function createfigure(X1, Y1,filename,ylabel_str,flag)
%CREATEFIGURE(X1, Y1)
%  X1:  scatter x
%  Y1:  scatter y

%  �� MATLAB �� 26-Dec-2019 09:18:01 �Զ�����

% ���� figure
fh = figure('InvertHardcopy','off','NumberTitle','off','Color',[1 1 1],'Visible','on');

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 5])

% ���� axes
axes1 = axes('Position',[0.1 0.13 0.87 0.8]);
hold(axes1,'on');

% ���� scatter
scatter(X1,Y1,'MarkerFaceColor',[0 0.498039215803146 0],...
    'MarkerEdgeColor',[0 0.498039215803146 0],...
    'Marker','.');

% ���� ��ֵ��
 Absmean = mean(abs(Y1));
 line([0,90],[Absmean,Absmean],'LineWidth',2,'Color','r','LineStyle','--'); 
 line([0,90],[-Absmean,-Absmean],'LineWidth',2,'Color','r','LineStyle','--');
 
 Absstd = std(abs(Y1));
  line([0,90],[Absstd,Absstd],'LineWidth',2,'Color','b','LineStyle','--'); 
 line([0,90],[-Absstd,-Absstd],'LineWidth',2,'Color','b','LineStyle','--');

% ���� xlabel
xlabel('Elevation(��)','FontSize',20,'Position',[45.00004291534424,-11.5],'HorizontalAlignment','center','FontName','Arial');

% ���� ylabel
ylabel(ylabel_str,'FontSize',20);

% ȡ�������е�ע���Ա���������� Y ��Χ
Y_min = -10;
Y_max = 10;
 ylim(axes1,[Y_min Y_max]);
% ȡ�������е�ע���Ա���������� Z ��Χ
% zlim(axes1,[-1 1]);
box(axes1,'on');


if flag == 0
    % ȡ�������е�ע���Ա���������� X ��Χ
     xlim(axes1,[0 90]);
     % ������������������
    set(axes1,'FontName','Arial','FontSize',20,'FontWeight','bold','GridAlpha',...
    0.3,'LineWidth',1,'XGrid','on','YGrid','on','XTick',[0 10 20 30 40 50 60 70 80 90],...
    'YGrid','on','YTick',[Y_min:2:Y_max]);
else
    % ȡ�������е�ע���Ա���������� X ��Χ
     xlim(axes1,[20 60]);
     % ������������������
    set(axes1,'FontName','Arial','FontSize',20,'FontWeight','bold','GridAlpha',...
    0.3,'LineWidth',1,'XGrid','on','YGrid','on','XTick',[20 30 40 50 60],...
    'YGrid','on','YTick',[Y_min:2:Y_max]);
end

% ���� textbox
textvalue = cell(1,1);
textvalue{1} = ['Mean:',num2str(round(Absmean*100)/100),'m','  ','Std:',num2str(round(Absstd*100)/100),'m'];
%textvalue{2} = ['Std:',num2str(round(Absstd*100)/100),'m'];

annotation('textbox',...
    [0.53466666666667 0.227430555555555 0.55777777777775 0.0674934536447264],...
    'String',textvalue,...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',20,...
    'FontName','Arial',...
    'HorizontalAlignment','left');

saveas(fh,filename,'tif');


