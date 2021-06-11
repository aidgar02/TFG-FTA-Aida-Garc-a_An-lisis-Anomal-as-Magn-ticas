%flujo de calor 

%relacion entre la CPD y el flujo de calor superficial en la region 

%Tomando temperatura de Curie promedio estimada para la zona T=580ºC
%Tomando capacidad calorífica C = 3 %valores estimados promedio entre 2,5-3

q=(580*3)./Zb_;    %flujo de calor 

figure(9)
contourf(q,'LineWidth',1.5)
title('MAPA DE FLUJO DE CALOR SUPERFICIAL DERIVADO DE LA CPD')
xlabel('Longitud [º]')
ylabel('Latitud [º]')


writetable(table(q),'flujodecalor')
