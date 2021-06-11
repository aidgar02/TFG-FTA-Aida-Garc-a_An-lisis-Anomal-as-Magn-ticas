%ajustes lineales 

% Sobre el codigoprincipal, escogemos la zonas de alta y baja frecuencia para obtener dos profundidades: la
% superior y la del centroide, efectuando un ajuste mediante mínimos cuadrados.

%% Ajuste Zt

%Queremos ajustar linealmente el ln del espectro de potencia en el
%intervalo k > 0.05 km 

% Ajuste lineal 1 => Profundidad de la parte superior del bloque (Zt)
X=k; %Defino eje x -> numero de onda (rad_km-1)
Y=log(P); %Defino eje y -> logaritmo de la densidad espectral de potencia
rango_zt=find(X>=0.05); %Selecciono rango de número onda altos
X_Zt=X(rango_zt); %Valores de número onda del rango seleccionado
Y_Zt=Y(rango_zt); %Valores de espectro poten. del rango seleccionado
%display 'Coeficientes del ajuste para Zt' 
ajusteZt=polyfit(X_Zt,Y_Zt,1);   %1=grado del polinomio del ajuste
%ajusteZt_refinado=polyval(ajusteZt,X_Zt);   %valores de ese
%polinomio


%%Ajuste lineal de mínimos cuadrados
poly1=X_Zt.*ajusteZt(1)+ajusteZt(2); % es el polinomio en sí para graficar el ajuste

%% Representación gráfica de los datos con sus respectivos ajustes
figure(7)
subplot(2,1,1)
plot(X,Y) %Asociada a Zt
hold on
plot(X_Zt,poly1,'r-')
%plot(X,f,'r-')
title('Estimación de Zt')
xlabel('Número de onda k [rad km^{-1}]')
ylabel('ln {[\phi_{\Delta T}(|k|)]}')
legend('ln(\Phi(k))','Ajuste lineal')
subplot(2,1,2)
sz=15;
scatter(X,Y,sz,'x')
hold on
plot(X_Zt,poly1,'r-')
legend('scattered ln(\Phi(k))','Ajuste lineal')
title('Valores exactos')


Zt=-(ajusteZt(1,1))*0.5;  %sale .14 

%% Ajuste Z_0

% Ajuste lineal 2 => Profundidad centroide (Zo)
X=k; %Defino eje x -> número de onda (rad_km-1)
Y=log((sqrt(P))./k); %Defino eje y -> densidad espectral de potencia
rango2=find((X>=0.0001 & X<=0.6)); %Selecciono rango de número onda bajos

%obs. la cota superior será tanto mayor cuanto más estrecha sea la fuente de la
%anomalía.



X_Z0=X(rango2); %Valores de número onda del rango seleccionado
Y_Z0=Y(rango2); %Valores de espectro poten. del rango seleccionado
%display 'Coeficientes del ajuste para Z0'
ajusteZ0=polyfit(X_Z0,Y_Z0,1);%polinomio de orden 1 para el ajuste 
%valores=polyval(ajusteZ0,X_Z0);  %este es el polinomio con los valores reales evaluados



%Ajuste lineal por minimos cuadrados
recta_ajustez0=X_Z0.*ajusteZ0(1)+ajusteZ0(2); % polinomio (recta) del ajuste para Z0

%Representación gráfica

figure(8)
subplot(2,1,1)
plot(X,Y) %Asociada a Zo
hold on
plot(X_Z0,recta_ajustez0,'r-')
title('Estimación Zo')
xlabel('Número de onda(k) [km^{-1}]')
ylabel('ln [(\phi_{\Delta T}(|k|)^{1/2} /k)]')
legend('ln(\phi(k)^{1/2}/k)','Ajuste lineal 0.001 < k < 0.5')

subplot(2,1,2)
sz=15;
scatter(X,Y,sz,'d')
hold on 
plot(X_Z0,recta_ajustez0,'r-')
title('Valores sin suavizar')
legend('scattered ln(\phi(k)^{1/2}/k)','Ajuste lineal 0.001 < k < 0.5')

Z0=-(ajusteZ0(1,1));  %sale 0

Zb=2*Z0-Zt;



%Observación. Los valores de las estimaciones dependen mucho de la
%resolución!! 

