%%Full Script for NPV with changing time intervals for discount rate%%
%%----------------Costs and Volume are changing-------------------%%
%--------------------------------------------------------------------%
%% Input Parameters%%
%%---Benefit Distribution (BD) Input Parameters---%%
%---Community Alongshore distances
D=25670;                %total distance of LBI, NJ
DtotalPER=0.715;        %total alongshore distance percentage of SB+LBT+BH project
Dtotal=D*DtotalPER;     %total alongshore distance of SB+LBT+BH project
DsbPER=0.0845;          %total alongshore distance perecentage of Ship Bottom
Dsb=D*DsbPER;           %total alongshore distance of Ship Bottom   
DlbtPER=0.5117;         %total alongshore distance percentage of Long Beach Township (excluding Brant Beach & North region of Division D)
Dlbt=D*DlbtPER;         %total alongshore distance of Long Beach Township
DbhPER=0.1188;          %total alongshore distance percentage of Beach Haven
Dbh=D*DbhPER;           %total alongshore distance of Beach Haven
Dbb=1475;
Dlava=4700;
Dex=2000;
%-----Total Sum of PVs 2017-----%
PVsb=879512000;         %total $sum of Ship Bottom properties
PVlbt=5164216465;       %total $sum of Long Beach Township properties
PVbh=1219111700;        %total $sum of Beach Haven properties
PV=PVsb+PVlbt+PVbh;     %total $sum of properties for entire dataset SB+LBT+BH
PVbb=133693900;
PVlava=1915425384;
PVex=1000000000;
%-----theta or MIP coefficients-----%
theta=0.0636698;        %total Marginal Implicit Price (MIP) value for all properties in dataset SB+LBT+BH
thetasb=0.1572;         %MIP of Ship Bottom
thetalbt=0.0134;        %MIP of Long Beach Township
thetabh=0.2071;         %MIP of Beach Haven
%%--Munciple Tax Rate per Community 2017--%%
TAXsb=0.0034;
TAXlbt=0.00236;
TAXbh=0.00406;
TAXbb=0.00481;
TAXlava=0.00311;
TAXex1=0.00025;
TAXex2=0.0005;
TAXex3=0.00005;
TAXex4=0.0001;
%%---Benefit (BD) totals for communities-----%
BD=PV*theta;            %total BD for all communities
BDsb=PVsb*thetasb;      %total BD for SB
BDlbt=PVlbt*thetalbt;   %total BD for LBT
BDbh=PVbh*thetabh;      %total BD for BH
%%---Populations per community---%
Popsb=1325;             %SB population
Poplbt=5312;            %LBT population
Popbh=1241;             %BH population
Pop=Popsb+Poplbt+Popbh; %ALL COMMUNITIES population
%%---Benefits per household---%%%
BDpop=BD/Pop;           %ALL COMMUNITIES
BDpopsb=BDsb/Popsb;     %Ship Bottom
BDpoplbt=BDlbt/Poplbt;  %Long Beach Township
BDpopbh=BDbh/Popbh;     %Beach Haven
%%---Benefits per meter alongshore---%%%
BDD=BD/Dtotal;           %ALL COMMUNITIES
BDDsb=BDsb/Dsb;         %Ship Bottom
BDDlbt=BDlbt/Dlbt;      %Long Beach Township
BDDbh=BDbh/Dbh;         %Beach Haven
%%---------------------------------------------%%
%%---Cost Distribution (CD) Input Parameters---%%
%%---------------------------------------------%%
%%---Nourishment Volume for entire LBI project, per episode
VolLOW=60;     %total estimation of volume per episode LOWER LIMIT (USACE2014) - 2mcy - roughly 60m^2 for each meter alongshore
VolHIGH=300;    %total estimation of volume per episode UPPER LIMIT - roughly 300m^2 (278.25m^2 when we consider top portion of dune added) for each meter alongshore
%%---Intial estimation of events (USACE - 113th Congress)
Events=7; %7 events throughout the 50yr time horizon
%%---VOLUMETOTALS
% totalLOWvol=VolLOW*Dlbt;
% totalHIGHvol=VolHIGH*Dlbt;
% totalLOWvol=VolLOW*Dbb;
% totalHIGHvol=VolHIGH*Dbb;
% totalLOWvol=VolLOW*Dlava;
% totalHIGHvol=VolHIGH*Dlava;
totalLOWvol=VolLOW*Dex;
totalHIGHvol=VolHIGH*Dex;
%%-------------------------------%%
%%-------------------------------%%
%%---Nourishment Volume for each community TOTAL over 50years
TOTVOLprojectLOW=(VolLOW*DtotalPER*Events);
TOTVOLsbLOW=(VolLOW*DsbPER*Events);
TOTVOLlbtLOW=(VolLOW*DlbtPER*Events);
TOTVOLbhLOW=(VolLOW*DbhPER*Events);
%%---Nourishment Volume for each community TOTAL over 50years
TOTVOLprojectHIGH=(VolHIGH*DtotalPER*Events);
TOTVOLsbHIGH=(VolHIGH*DsbPER*Events);
TOTVOLlbtHIGH=(VolHIGH*DlbtPER*Events);
TOTVOLbhHIGH=(VolHIGH*DbhPER*Events);
%%---LOWER Nourishment Volume for each community TOTAL per meter over 50years
VolNmLOW=(TOTVOLprojectLOW/Dtotal);
VolNsbmLOW=(TOTVOLsbLOW/Dsb);
VolNlbtmLOW=(TOTVOLlbtLOW/Dlbt);
VolNbhmLOW=(TOTVOLbhLOW/Dbh);
%%---HIGHER Nourishment Volume for each community TOTAL per meter over 50years
VolNmHIGH=(TOTVOLprojectHIGH/Dtotal);
VolNsbmHIGH=(TOTVOLsbHIGH/Dsb);
VolNlbtmHIGH=(TOTVOLlbtHIGH/Dlbt);
VolNbhmHIGH=(TOTVOLbhHIGH/Dbh);
%%---Cost-Share percentage of contributions from local communities
LocalContributionFed=0.125;  %represents Fed gov't contributing 50%
%%---Discount rate------%
% discount=0.06875; fig=8;
discount=0.03;  fig=9;
% discount=0.01;  fig=10;
% discount=0.001; fig=11;

% TAXlava=0.00306;
%%---Total Time interval of Project---%%
T=50;
%%-------------------------------------------%%
%%-------Initial parameters for check--------%%
%%-------------------------------------------%%
%%---Starting Nourishment Cost (2016 value)
Cost=22.06; %starting cost 2016 (weeksmarine)
% Cost=41.13; %min cost for lbt to reach Net Loss, beyond continues neg.
% Cost=47.98; %test runs
%% External Loop Vectors for Storage
run=100;
time=1:1:50;
it=length(time);
cost=linspace(22.06,100,run);
ic=length(cost);
volume=linspace(0,totalHIGHvol,run);
iv=length(volume);

% time=1:1:50;
% it=length(time);
% cost=22.06:13:100;
% ic=length(cost);
% volume=totalLOWvol:7187600:totalHIGHvol;
% iv=length(volume);
%% Building Result Matrix for regime plot
result_vector_CD=zeros(ic,1);      
result_matrix_CDsum=zeros(ic,iv);         %by doing it,1 this turns it into a column
DIS=zeros(1,it);
TOTVOL=zeros(1,it);
CD=zeros(1,it);
%% Plots
% figure(2)
% for v=1:iv
%     for c=1:ic
%         for t=1:it
%             %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
%             %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%     end
%     result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
% end
% result_matrix_NB=(((PVlbt*TAXlbt)-result_matrix_CDsum)/T)/Dlbt;
% % result_matrix_NBsb=((BDDsb/T)-((result_matrix_CDsumsb/T)/Dsb));
% %plot information
% pcolor(((volume/Dlbt)*7),cost,result_matrix_NB)
% hold on
% shading flat
% % colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=(result_matrix_NB);
% [X,Y]=meshgrid(((volume/Dlbt)*7),cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('LBT NB $/yr/m','fontsize',15)

% figure(3)
% for v=1:iv
%     for c=1:ic
%         for t=1:it
%             %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
%             %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%     end
%     result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
% end
% result_matrix_NB=(((PVbb*TAXbb)-result_matrix_CDsum)/T)/Dbb;
% % result_matrix_NBsb=((BDDsb/T)-((result_matrix_CDsumsb/T)/Dsb));
% %plot information
% pcolor(((volume/Dbb)*7),cost,result_matrix_NB)
% hold on
% shading flat
% % colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=(result_matrix_NB);
% [X,Y]=meshgrid(((volume/Dbb)*7),cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('Bradley Beach NB $/yr/m','fontsize',15)
% 
% figure(4)
% for v=1:iv
%     for c=1:ic
%         for t=1:it
%             %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
%             %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%     end
%     result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
% end
% result_matrix_NB=(((PVlava*TAXlava)-result_matrix_CDsum)/T)/Dlava;
% % result_matrix_NBsb=((BDDsb/T)-((result_matrix_CDsumsb/T)/Dsb));
% %plot information
% pcolor(((volume/Dlava)*7),cost,result_matrix_NB)
% hold on
% shading flat
% % colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=(result_matrix_NB);
% [X,Y]=meshgrid(((volume/Dlava)*7),cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('lava NB $/yr/m','fontsize',15)

figure(3)
for v=1:iv
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
            CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
            BD(t)=(PVex*TAXex3)/DIS(t);
            BDsum=sum(BD);
        end
        result_vector_CD(c)=CDsum;
    end
    result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
end
result_matrix_NB=((BDsum-result_matrix_CDsum)/T)/Dex;
% result_matrix_NBsb=((BDDsb/T)-((result_matrix_CDsumsb/T)/Dsb));
%plot information
pcolor(((volume/Dex)*7),cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=(result_matrix_NB);
[X,Y]=meshgrid(((volume/Dex)*7),cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('0.005% Tax','fontsize',15)

figure(4)
for v=1:iv
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
            CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
            BD(t)=(PVex*TAXex4)/DIS(t);
            BDsum=sum(BD);
        end
        result_vector_CD(c)=CDsum;
    end
    result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
end
result_matrix_NB=((BDsum-result_matrix_CDsum)/T)/Dex;
% result_matrix_NBsb=((BDDsb/T)-((result_matrix_CDsumsb/T)/Dsb));
%plot information
pcolor(((volume/Dex)*7),cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=(result_matrix_NB);
[X,Y]=meshgrid(((volume/Dex)*7),cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('0.01% Tax','fontsize',15)

figure(5)
for v=1:iv
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
            CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
            BD(t)=(PVex*TAXex1)/DIS(t);
            BDsum=sum(BD);
        end
        result_vector_CD(c)=CDsum;
    end
    result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
end
result_matrix_NB=((BDsum-result_matrix_CDsum)/T)/Dex;
% result_matrix_NBsb=((BDDsb/T)-((result_matrix_CDsumsb/T)/Dsb));
%plot information
pcolor(((volume/Dex)*7),cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=(result_matrix_NB);
[X,Y]=meshgrid(((volume/Dex)*7),cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('0.025% Tax','fontsize',15)

figure(6)
for v=1:iv
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
            CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
            BD(t)=(PVex*TAXex2)/DIS(t);
            BDsum=sum(BD);
        end
        result_vector_CD(c)=CDsum;
%         result_vector_BD(c)=BDsum;
    end
    result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
%     result_matrix_BDsum(:,v)=result_vector_BD;
end
result_matrix_NB=((BDsum-result_matrix_CDsum)/T)/Dex;
% result_matrix_NBsb=((PVex*TAXex2*T)-(result_matrix_CDsum/T))/Dex;
%plot information
pcolor(((volume/Dex)*7),cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=(result_matrix_NB);
[X,Y]=meshgrid(((volume/Dex)*7),cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('0.05% Tax','fontsize',15)

figure(7)
for v=1:iv
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
            CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
            BD(t)=(100000)/DIS(t);
            BDsum=sum(BD);
        end
        result_vector_CD(c)=CDsum;
    end
    result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
end
result_matrix_NB=((BDsum-result_matrix_CDsum)/T)/Dex;
% result_matrix_NBsb=((BDDsb/T)-((result_matrix_CDsumsb/T)/Dsb));
%plot information
pcolor(((volume/Dex)*7),cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=(result_matrix_NB);
[X,Y]=meshgrid(((volume/Dex)*7),cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('100K Budget/year','fontsize',15)

figure(8)
for v=1:iv
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
            CD(t)=(((cost(c)*(volume(v)*Events/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);           %storing the values for the cost function CD over time, into a matrix
            BD(t)=(500000)/DIS(t);
            BDsum=sum(BD);
        end
        result_vector_CD(c)=CDsum;
%         result_vector_BD(c)=BDsum;
    end
    result_matrix_CDsum(:,v)=result_vector_CD;   %(e,:) take this whole matrix and store it
%     result_matrix_BDsum(:,v)=result_vector_BD;
end
result_matrix_NB=((BDsum-result_matrix_CDsum)/T)/Dex;
% result_matrix_NBsb=((PVex*TAXex2*T)-(result_matrix_CDsum/T))/Dex;
%plot information
pcolor(((volume/Dex)*7),cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=(result_matrix_NB);
[X,Y]=meshgrid(((volume/Dex)*7),cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('50yr Nourishment Volume per meter alongshore (m)','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('500K Budget/year','fontsize',15)